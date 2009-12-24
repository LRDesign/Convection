require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index" do
  before(:each) do         
    activate_authlogic
    render '/home/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should succeed" do
    response.should be_success
  end
end
