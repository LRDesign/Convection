require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do

  before(:each) do
    activate_authlogic
    login_as(Factory(:user))
  end

  describe "authorization" do
    it "should deny access to regular user" do
      get :index
      response.should be_redirect
      flash[:error].should_not be_nil
    end
    it "should allow access to admin user" do
      logout
      login_as(Factory(:admin))
      get :index
      response.should be_success
    end
  end

end
