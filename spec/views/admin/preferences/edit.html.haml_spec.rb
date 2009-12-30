require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/preferences/edit.html.haml" do
  
  before(:each) do
    activate_authlogic
    login_as(Factory(:admin))
    assigns[:preferences] = @preferences = Preferences.find(:first)
    render "/admin/preferences/edit"    
  end
  
  it "should succeed" do
    response.should be_success
  end

  it "should render edit form" do
    pending "not sure about setting the method"
    response.should have_tag("form[action=#{admin_preferences_path}][method=put]") 
  end
end


