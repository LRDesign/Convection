require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::LogsController do
  before(:each) do
    activate_authlogic
    login_as(Factory(:admin))
  end
  
  describe 'routing' do
    it "recognizes and generates #index" do
      { :get => "/admin/logs" }.should route_to(:controller => "admin/logs", :action => "index")
    end    
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
