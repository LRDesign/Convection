require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.haml" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [ Factory(:user), Factory(:user) ]
  end

  it "should render list of users" do
    render "/users/index.html.haml"
    response.should have_tag("tr>td", "value for login", 2)
    response.should have_tag("tr>td", "value for email", 2)
    response.should have_tag("tr>td", "value for name", 2)
  end
end

