class Admin::AdminController < ApplicationController
  before_filter :check_admin_authorization
    
  def check_admin_authorization
    unless logged_in? and current_user.admin?
      flash[:error] = "You are not authorized to access that feature."
      redirect_to home_url
    end
  end
end
