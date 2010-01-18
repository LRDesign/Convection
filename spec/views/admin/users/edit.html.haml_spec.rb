require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/users/edit.html.haml" do
  include Admin::UsersHelper
  
  before(:each) do
    assigns[:user] = @user = Factory(:user)
  end

  it "should succeed" do
    render "/admin/users/edit.html.haml"
    response.should be_success
  end
end

