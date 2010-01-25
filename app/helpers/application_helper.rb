# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper      
                
  # same function as application_controller.rb's logged_in? method
  def logged_in?
    !current_user.nil?
  end
  
end
