require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  describe "route generation" do  
    it "should map #edit" do
      route_for(:controller => "users", :action => "edit", :id => '1').should == "/users/1/edit"
    end  
    
    it "should map #update" do
      route_for(:controller => "users", :action => "update", :id => '1').should == { :path => "/users/1", :method => :put }
    end  
    
  end

  describe "route recognition" do    
    it "should generate params for #edit" do
      params_from(:get, "/users/1/edit").should == {:controller => "users", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/users/1").should == {:controller => "users", :action => "update", :id => "1"}
    end  
  end
  
  # These routes should be unavailable for security reasons.
  describe "unavailable routes" do
    it "should not route GET index" do
      {:get => '/users'}.should_not be_routable
    end
    
    it "should not route GET show" do
      {:get => '/users/1'}.should_not be_routable      
    end
    
    it "should not route GET new" do
      pending "this routes as a GET show with ID of 'new'.  Weird."
      {:get => '/users/new'}.should_not be_routable
    end
    
    it "should not route POST create" do
      {:post => '/users'}.should_not be_routable
    end
    
    it "should not route DELETE destroy" do
      {:delete => '/users/1'}.should_not be_routable      
    end
  end
end
