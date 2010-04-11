require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  #Delete this example and add some real ones
  it "should use UserSessionsController" do
    controller.should be_an_instance_of(UserSessionsController)
  end
  
  describe "POST create" do
    before(:each) do
      @user = Factory.create(:user)
    end
               
    describe "with correct parameters" do
      it "should succeed" do
        post :create, :user_session => {:login => @user.login, :password => 'foobar'}
        assigns(:user_session).user.should == @user      
      end
      
      it "should redirect home" do
        post :create, :user_session => {:login => @user.login, :password => 'foobar'}
        response.should redirect_to(home_url)   
      end
            
      it "should add a long entry" do
        old = LogEntry.count
        post :create, :user_session => {:login => @user.login, :password => 'foobar'}
        response.should redirect_to(home_url)           
        LogEntry.count.should eql(old + 1)
      end
    end
    
    it "should fail with correct parametets" do
      post :create, :user_session => {:login => @user.login, :password => 'wrong password'}
      assigns(:user_session).user.should be_nil
    end
    
  end
  
end
