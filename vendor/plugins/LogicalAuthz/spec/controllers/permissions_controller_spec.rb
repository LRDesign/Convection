require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PermissionsController do
  include LogicalAuthz::MockAuth
  integrate_views
  before(:each) do
    @person = login_as(Factory.create(:az_admin))    
    request.env["HTTP_ACCEPT"] = "application/javascript" 
    @group = Factory.create(:group)
  end

  describe "POST Created" do
    it "should respond with javascript" do
      post  :create, {
        "permission"=> "true", 
        "group"=> @group.id, 
        "p_action"=>"show",
        "p_controller" => "blah",
        "object"=> 123
      }
      response.should have_rjs
    end
  end
end
