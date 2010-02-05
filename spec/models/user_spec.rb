# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  login               :string(255)
#  email               :string(255)
#  name                :string(255)
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :login => "NewUser",
      :password => "12345678",
      :password_confirmation => "12345678",
      :email => "newuser@newuser.com",
      :name => "New User"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should succeed creating a new :user from the Factory" do
    Factory.create(:user)
  end

  # TODO: rewrite or eliminate these when the groups module is in
  describe "admin" do
    it "should not be admin for default user" do
      Factory.build(:user).should_not be_admin
    end
    it "should not be admin for default user" do
      Factory.build(:admin).should be_admin
    end
    
  end                             
  
  describe "document permissions" do  
    before(:each) do      
      @user = Factory.create(:user) 
      @other = Factory.create(:user)
      @group = Factory.create(:group)
      @user.groups << @group
      @user.save!
      @doc = Factory.create(:document, :user => @other)
    end                        
    it "shouldn't give the user show access" do
      @user.can?(:show, @doc).should be_false      
    end                                               
    it "should give the user show access if they created the doc" do
      @doc.user = @user
      @doc.save!
      @user.can?(:show, @doc).should be_true      
    end
    it "should give show access if the group has show permissions" do
      @group.permissions.create(:controller => 'documents', :action => 'show', :subject_id => @doc.id)
      @user.can?(:show, @doc).should be_true            
    end    
    it "should not give show access just because a different group has show perms" do                 
      @group2 = Factory.create(:group)
      @group2.permissions.create(:controller => 'documents', :action => 'show', :subject_id => @doc.id)
      @user.can?(:show, @doc).should be_false                  
    end    
    it "should give access if the user is an admin" do
      admin = Factory.create(:admin)
      admin.can?(:show, @doc).should be_true
    end
  end
  
end
