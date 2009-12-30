require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/users/show.html.haml" do
  include Admin::UsersHelper
  
  before(:each) do
    assigns[:user] = @user = Factory(:user)
  end

  it "should render attributes in <p>" do
    render "/admin/users/show.html.haml"
    response.should be_success
  end
end

