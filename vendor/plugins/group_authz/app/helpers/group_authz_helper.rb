module GroupAuthz
  Permission = ::Permission

  def self.set_permission_model(klass)
    remove_const(:Permission)
    const_set(:Permission, klass)
  end

  module Helper
    def authorized?(criteria={})
      current_user = AuthnFacade.current_user(self)
      return false if current_user.blank?
      controller_class_path = criteria[:controller]
      controller_class_path = controller_class_path.to_s if Symbol === controller_class_path
      controller_class = ::ApplicationController

      if String === controller_class_path
        controller_class_name = controller_class_path.camelize + "Controller"
        begin 
          controller_class = controller_class_name.constantize
        rescue NameError
          controller_class = ::ApplicationController
        end
      else
        controller_class = controller.class
      end

      criteria = {:action => action_name, :id => params[:id]}.merge(criteria)

      controller_class.can_authorize(current_user, criteria)
    end 
        
    # returns an array of group names and ids (suitable for select_tag)
    # for which <user> is not a member
    def nonmembered_groups(user)
      (Group.all - user.groups).map { |g| [ g.name, g.id ] }
    end    
  end
end
