require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocumentsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "documents", :action => "index").should == "/documents"
    end
  
    it "should map #new" do
      route_for(:controller => "documents", :action => "new").should == "/documents/new"
    end
  
    it "should map #show" do
      route_for(:controller => "documents", :action => "show", :id => '1').should == "/documents/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "documents", :action => "edit", :id => '1').should == "/documents/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "documents", :action => "update", :id => '1').should == { :path => "/documents/1", :method => :put }
    end
  
    it "should map #destroy" do
      route_for(:controller => "documents", :action => "destroy", :id => '1').should == { :path => "/documents/1", :method => :delete }
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/documents").should == {:controller => "documents", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/documents/new").should == {:controller => "documents", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/documents").should == {:controller => "documents", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/documents/1").should == {:controller => "documents", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/documents/1/edit").should == {:controller => "documents", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/documents/1").should == {:controller => "documents", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/documents/1").should == {:controller => "documents", :action => "destroy", :id => "1"}
    end
  end
end
