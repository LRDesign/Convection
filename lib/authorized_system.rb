module AuthorizedSystem
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  include AuthorizationHelper

  def redirect_to_lobby(message = "You aren't authorized for that")
    flash[:error] = message
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to home_url
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
  end

  class CheckAuthorization
    def self.filter(controller)
      if controller.class.read_inheritable_attribute(:whole_controller_authorization)
        if controller.authorized?
          return true
        else
          controller.redirect_to_lobby("You are not authorized to use these tools.")
          return false
        end
      elsif (controller.class.read_inheritable_attribute(:requires_action_authorization) || []).include?(controller.action_name.to_sym)
        if controller.authorized?
          return true
        else
          controller.redirect_to_lobby("You are not authorized to perform this action.  Perhaps you need to log in?")
          return false
        end
      else
        return true
      end
    end

  end
end
