require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')     

describe UploadsController do
  before(:each) do
    activate_authlogic
  end
    
  describe "while logged out " do
    before(:each) { logout }
    it "should redirect" do
      get 'index'
      response.should be_redirect
    end                          
    it "should flash an error message" do
      get 'index'  
      flash[:notice].should_not be_nil
    end
  end
  
  describe "while logged in" do
    before(:each) do
      @user = login_as Factory(:user) 
      @other = Factory(:user, :name => "Joe")
      @d1 = Factory.create(:document, :user => @user)   
      @d2 = Factory.create(:document, :user => @user)   
      @d3 = Factory.create(:document, :user => @other)   
    end
    it "should be successful" do
      get 'index'
      response.should be_success
    end                         
    
    it "should show all of the user's uploads" do
      get 'index'
      assigns[:documents].should include(@d1)
      assigns[:documents].should include(@d2)      
    end                                            
    
    it "should not include any other user's uploads" do
      get 'index'
      assigns[:documents].should_not include(@d3)      
    end
  end
end
