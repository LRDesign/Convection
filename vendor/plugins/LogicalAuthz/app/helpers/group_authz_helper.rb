module GroupAuthz
  Permission = ::Permission

  def self.set_permission_model(klass)
    remove_const(:Permission)
    const_set(:Permission, klass)
  end

  module Helper
    def authorized?(criteria=nil)
      criteria ||= {}
      criteria = {:controller => controller, :action => action_name, :id => params[:id]}.merge(criteria)
      unless criteria.has_key?(:group) or criteria.has_key?(:user)
        criteria[:user] = AuthnFacade.current_user(self)
      end

      GroupAuthz.is_authorized?(criteria)
    end 
        
    # returns an array of group names and ids (suitable for select_tag)
    # for which <user> is not a member
    def nonmembered_groups(user)
      (Group.all - user.groups).map { |g| [ g.name, g.id ] }
    end    
  end
end
