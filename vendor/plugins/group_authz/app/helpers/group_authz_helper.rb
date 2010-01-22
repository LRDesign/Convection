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
      controller_class_path = criteria.delete(:controller)
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


      controller_class.can_authorize(current_user, criteria)
    end
  end
end
