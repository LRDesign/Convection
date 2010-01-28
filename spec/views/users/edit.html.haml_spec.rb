require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/edit.html.haml" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = Factory(:user)
  end

  it "should render edit form" do
    render "/users/edit.html.haml"
    
    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_name[name=?]', "user[name]")
    end
  end
end


