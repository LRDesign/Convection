require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UploadsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "uploads", :action => "index").should == "/uploads"
    end  
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/uploads").should == {:controller => "uploads", :action => "index"}
    end
  end
end
