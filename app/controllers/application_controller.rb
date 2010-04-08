# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'group_authz'

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include GroupAuthz::Application                       
  before_filter :retrieve_site_preferences             
  before_filter :ssl_preferred
  
  
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user_session, :current_user


  before_filter :mailer_set_url_options

  private
  def require_user    
    #debugger
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  private
  def retrieve_site_preferences
    @preferences ||= Preferences.find(:first)
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end  
  
  def ssl_preferred
    if !request.ssl? && Rails.env.production? && @preferences.require_ssl?   
      redirect_to "https://" + request.host + request.request_uri
      flash.keep
      return false    
    end    
  end
  
  # Scrub sensitive parameters from the log
  filter_parameter_logging :password
end
