require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PermissionsController do
  before(:each) do
    activate_authlogic
    @person = login_as(users(:admin))    
    request.env["HTTP_ACCEPT"] = "application/javascript" 
    @group = groups(:registered)
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
