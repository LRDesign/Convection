require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/users/index.html.haml" do
  include Admin::UsersHelper
  
  before(:each) do
    activate_authlogic
    login_as(Factory(:admin))
    assigns[:users] = [ Factory(:user), Factory(:admin) ]
    render '/admin/users/index'
  end

  it "should succeed" do
    response.should be_success
  end
end

