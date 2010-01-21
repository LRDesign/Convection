require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/groups/show.html.haml" do
  include Admin::UsersHelper
  
  before(:each) do
    activate_authlogic
    @admin = login_as(Factory(:admin))
    @group = Factory.create(:group, :name => 'foo')
    @group.users << @user1 = Factory.create(:user)
    @group.users << @user2 = Factory.create(:user)        
    
    assigns[:group] = @group
    assigns[:users] = [ @user1, @user2 ]
    render '/admin/groups/show'
  end

  it "should succeed" do
    response.should be_success
  end
end

