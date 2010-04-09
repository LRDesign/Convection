require 'group_authz_helper'

class Group; end

module GroupAuthz
  PermissionSelect = "controller = :controller AND " +
    "group_id IN (:group_ids) AND " +
    "((action IS NULL AND subject_id IS NULL) OR " +
    "(action IN (:action_names) AND " +
    "(subject_id IS NULL OR subject_id = :subject_id)))"

  class << self
    def unauthorized_groups
      return @unauthorized_groups unless @unauthorized_groups.nil?
      groups = unauthorized_group_names.map do |name|
        Group.find_by_name(name)
      end
      if Rails.configuration.cache_classes
        @unauthorized_groups = groups 
      end
      return groups
    end
    def clear_unauthorized_groups
      @unauthorized_groups = nil
    end

    attr_accessor :unauthorized_group_names

    def unauthorized_group_names
      @unauthorized_group_names ||= []
    end
  end


  def self.is_authorized?(criteria={})
    criteria ||= {}

    controller_class = ::ApplicationController

    case criteria[:controller]
    when Class
      if GroupAuthz::Application > criteria[:controller]
        controller_class = criteria[:controller]
      end
    when GroupAuthz::Application
      controller_class = criteria[:controller].class
    when String, Symbol
      controller_class_name = criteria[:controller].to_s.camelize + "Controller"
      begin 
        controller_class = controller_class_name.constantize
      rescue NameError
      end
    end

    #TODO Fail if controller unspecified?

    criteria[:group] = criteria[:group].nil? ? [] : [*criteria[:group]]
    if criteria.has_key?(:user) and not criteria[:user].nil?
      criteria[:group] += criteria[:user].groups
    end
    if criteria[:group].empty?
      criteria[:group] += unauthorized_groups
    end

    #TODO Fail if group unspecified and user unspecified?

    actions = [*criteria[:action]].compact
    criteria[:action_aliases] = actions.map do |action|
      controller_class.grant_aliases_for(action)
    end.flatten + actions.map{|action| action.to_sym}

    controller_class.authorization_procs.each do |prok|
      approval = prok.call(criteria[:user], criteria) #Tempted to remove the user param
      next if approval == false
      next if approval.blank?
      return true
    end

    select_on = {
      :group_ids => criteria[:group].map {|grp| grp.id},
      :controller => controller_class.controller_path,
      :action_names => criteria[:action_aliases].map {|a| a.to_s},
      :subject_id => criteria[:id] 
    }

    Rails.logger.debug{ select_on.inspect }
    allowed = GroupAuthz::permission_model.exists?([PermissionSelect, select_on])
    Rails.logger.info{ "Denied: #{select_on.inspect}"} unless allowed
    return allowed
  end

  module Application
    def self.included(klass)
      klass.extend(ClassMethods)
    end
    include Helper

    def redirect_to_lobby(message = "You aren't authorized for that")
      flash[:error] = message
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to home_url
      end
    end

    def check_authorized
      current_user = AuthnFacade.current_user(self)

      criteria = {
        :user => current_user, 
        :controller => self.class,
        :action => action_name, 
        :id => params[:id]
      }

      if GroupAuthz.is_authorized?(criteria)
        flash[:group_authorization] = true
        return true
      else
        redirect_to_lobby("Your account is not authorized to perform this action.")
        flash[:group_authorization] = false
        return false
      end
    end

    module ClassMethods
      def needs_authorization(*actions)
        before_filter CheckAuthorization
        if actions.empty?
          write_inheritable_attribute(:whole_controller_authorization, true)
        else
          write_inheritable_array(:requires_action_authorization, actions)
        end
      end

      def grant_aliases(hash)
        aliases = read_inheritable_attribute(:grant_alias_hash) || Hash.new{|h,k| h[k] = []}
        hash.each_pair do |grant, allows|
          [*allows].each do |allowed|
            aliases[allowed.to_sym] << grant.to_sym
          end
        end
        write_inheritable_attribute(:grant_alias_hash, aliases)
      end
      
      def grant_aliases_for(action)
        grant_aliases = read_inheritable_attribute(:grant_alias_hash)
        action = action.to_sym

        if not grant_aliases.nil? and grant_aliases.has_key?(action)
          return grant_aliases[action]
        else
          return []
        end
      end

      def dynamic_authorization(&block)
        write_inheritable_array(:dynamic_authorization_procs, [proc &block])
      end

      def authorization_procs
        read_inheritable_attribute(:dynamic_authorization_procs) || []
      end

      def admin_authorized(*actions)
        actions.map!{|action| action.to_sym}
        dynamic_authorization do |user, criteria|
          unless actions.nil? or actions.empty?
            return false if (actions & criteria[:action_aliases]).empty?
          end
          return criteria[:group].include?(Group.admin_group)
        end
      end
    end

    class CheckAuthorization
      def self.filter(controller)
        if controller.class.read_inheritable_attribute(:whole_controller_authorization)
          return controller.check_authorized
        elsif (controller.class.read_inheritable_attribute(:requires_action_authorization) || []).include?(controller.action_name.to_sym)
          return controller.check_authorized
        else
          return true
        end
      end
    end
  end
end
