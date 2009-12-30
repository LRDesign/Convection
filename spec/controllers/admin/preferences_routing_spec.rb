require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PreferencesController do
  describe "route generation" do
    it "should map #edit" do
      route_for(:controller => "admin/preferences", :action => "edit").should == "admin/preferences/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "admin/preferences", :action => "update").should == { :path => "admin/preferences", :method => :put }
    end
  end

  describe "route recognition" do
    it "should generate params for #edit" do
      params_from(:get, "/admin/preferences/edit").should == {:controller => "admin/preferences", :action => "edit"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/admin/preferences").should == {:controller => "admin/preferences", :action => "update"}
    end
  end
end
