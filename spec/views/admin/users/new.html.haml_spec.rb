require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/users/new.html.haml" do
  include Admin::UsersHelper
  
  before(:each) do
    activate_authlogic
    login_as Factory(:admin)
    assigns[:user] = Factory.build(:user)
    render "/admin/users/new.html.haml"
  end

  it "should succeed" do
    response.should be_success
  end
  
  it "should render new form" do
      
    response.should have_tag("form[action=?][method=post]", admin_users_path) do
      with_tag("input#user_login[name=?]", "user[login]")
      with_tag("input#user_email[name=?]", "user[email]")
      with_tag("input#user_name[name=?]", "user[name]")
    end
  end
end


