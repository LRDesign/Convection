require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new.html.haml" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = Factory.build(:user)
  end

  it "should render new form" do
    render "/users/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_login[name=?]", "user[login]")
      with_tag("input#user_email[name=?]", "user[email]")
      with_tag("input#user_name[name=?]", "user[name]")
    end
  end
end


