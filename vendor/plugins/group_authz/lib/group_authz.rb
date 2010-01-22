require 'group_authz_helper'

module GroupAuthz
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

      return false if current_user.blank?

      if self.class.can_authorize(current_user)
        flash[:group_authorization] = true
        return true
      else
        redirect_to_lobby("You are not authorized to perform this action.  Perhaps you need to log in?")
        flash[:group_authorization] = false
        return false
      end
    end

    module ClassMethods
      def can_authorize(user, criteria=nil)
        criteria ||= {}

        groups = criteria[:group] ? [criteria[:group]] : user.groups

        (read_inheritable_attribute(:dynamic_authorization_procs) || []).each do |prok|
          approval = prok.call(criteria)
          next if approval == false
          next if approval.blank?
          return true
        end

        p criteria
        select_on = {
          :group_id => groups.map{|grp| grp.id},
          :controller => controller_path,
          :action => nil,
          :subject_id => nil
        }

        permissions = GroupAuthz::Permission.find(:first, :conditions => select_on)
        p [select_on, permissions]
        return true unless permissions.nil?

        select_on[:action] = criteria[:action] || action_name
        p [select_on, permissions]
        permissions = GroupAuthz::Permission.find(:first, :conditions => select_on)
        return true unless permissions.nil?

        select_on[:subject_id] = criteria[:id] || params["id"]
        p [select_on, permissions]
        permissions = GroupAuthz::Permission.find(:first, :conditions => select_on)
        return (not permissions.nil?)
      end

      def needs_authorization(*actions)
        before_filter CheckAuthorization
        if actions.empty?
          write_inheritable_attribute(:whole_controller_authorization, true)
        else
          write_inheritable_array(:requires_action_authorization, actions)
        end
      end

      def dynamic_authorization(&block)
        write_inheritable_array(:dynamic_authorization_procs, [proc &block])
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
