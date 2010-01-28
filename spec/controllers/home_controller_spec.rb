require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  before(:each) do
    activate_authlogic
  end


  describe "GET 'index'" do
    describe "when logged in" do
      before(:each) do
        login_as Factory(:user)
      end
      it "should redirect to the documents index" do
        get :index
        response.should redirect_to(documents_path)
      end
    end

    describe "when logged out" do
      before(:each) do
        logout
      end
      it "should redirect to the login page" do
        get :index
        response.should redirect_to(login_path)
      end
      
    end
  end
end
