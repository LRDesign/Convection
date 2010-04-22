module LogicalAuthz
  class << self
    def set_permission_model(klass)
      @perm_model = klass
    end

    def set_group_model(klass)
      @group_model = klass
    end

    def permission_model
      @perm_model ||= ::Permission rescue nil
    end

    def group_model
      @group_model ||= ::Group rescue nil
    end
  end



  module Helper
    def authorized?(criteria=nil)
      criteria ||= {}
      criteria = {:controller => controller, :action => action_name, :id => params[:id]}.merge(criteria)
      unless criteria.has_key?(:group) or criteria.has_key?(:user)
        criteria[:user] = AuthnFacade.current_user(self)
      end

      LogicalAuthz.is_authorized?(criteria)
    end 
        
    # returns an array of group names and ids (suitable for select_tag)
    # for which <user> is not a member
    def nonmembered_groups(user)
      (LogicalAuthz::group_model.all - user.groups).map { |g| [ g.name, g.id ] }
    end    
  end
end
