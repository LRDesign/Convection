require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_sessions/new.html.haml" do
  before(:each) do           
    activate_authlogic
    assigns[:user_session] = UserSession.new
    assigns[:preferences] = Preferences.find(:first)
  end

  it "should render the login form successfully" do
    render "/user_sessions/new.html.haml"            
    response.should be_success
  end                         
  
  it "should have a link to the reset password tool if password resets are allowed" do
    assigns[:preferences].allow_password_resets = true
    render "/user_sessions/new.html.haml"            
    response.should have_tag('a[href=?]', new_password_reset_path)    
  end
  
  it "should not have a link to the reset password tool if password resets are disallowed" do
    assigns[:preferences].allow_password_resets = false
    render "/user_sessions/new.html.haml"            
    response.should_not have_tag('a[href=?]', new_password_reset_path)        
  end
end


