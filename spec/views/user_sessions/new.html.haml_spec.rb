require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_sessions/new.html.haml" do
  before(:each) do           
    activate_authlogic
    assigns[:user_session] = UserSession.new
  end

  it "should render the login form successfully" do
    render "/user_sessions/new.html.haml"            
    response.should be_success
  end
end


