require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GroupsUsersController do
  include GroupAuthz::MockAuth

  before(:each) do 
    @admin = login_as( Factory.create(:az_admin) )
    request.env['HTTP_REFERER'] = "http://test.host/previous/page"
    @user = Factory.create(:az_account)
    @user.groups.clear
    @group = Factory.create(:group, :name => "registered")
  end
  
  it "group should exist" do
    @group.should_not be_nil
  end

  describe "POST 'create'" do
    it "should succeed" do
      post 'create', :user_id => @user.id, :group_id => @group.id
      response.should be_redirect
    end
    
    it "should create the association" do
      post 'create', :user_id => @user.id, :group_id => @group.id
      @user.reload.groups.should include(@group)        
    end    
  end

  describe "GET 'destroy'" do
    before(:each) do
      @user.groups << @group
    end
    
    it "should be successful" do
      delete 'destroy', :user_id => @user.id, :group_id => @group.id      
      response.should be_redirect
    end

    it "should delete the association" do
      delete 'destroy', :user_id => @user.id, :group_id => @group.id
      @user.reload.groups.should_not include(@group)        
    end    
    
    it "should not allow removing a user from all_users"     
  end
end
