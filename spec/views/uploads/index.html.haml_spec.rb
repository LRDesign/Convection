require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe "/uploads/index" do
  before(:each) do           
    activate_authlogic                
    login_as Factory(:user)    
    assigns[:documents] = [ Factory(:document), Factory(:document) ]             
    render 'uploads/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should succeed" do
    response.should be_success
  end
end
