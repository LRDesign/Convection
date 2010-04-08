require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')    

describe Preferences do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    Factory.create(:preferences)
  end
  
  it "should not be valid if notifications are turned on but no server is set" do
    Factory.build(:preferences, 
      :upload_notifications => true, :smtp_server => nil
    ).should_not be_valid
  end
  
  describe "smtp_prefs_changed?" do
    before(:each) do
      @prefs = Factory.create(:preferences)
    end
    it "should be true if smtp_server is chnaged" do
      @prefs.smtp_server = "some.name"
      @prefs.should be_smtp_prefs_changed
    end       
    it "should be true if smtp_port is chnaged" do
      @prefs.smtp_port = 527
      @prefs.should be_smtp_prefs_changed
    end
    it "should be true if smtp_uses_tls is chnaged" do
      @prefs.smtp_uses_tls = !@prefs.smtp_uses_tls
      @prefs.should be_smtp_prefs_changed
    end
    it "should be true if smtp_username is chnaged" do
      @prefs.smtp_username = "my_name"
      @prefs.should be_smtp_prefs_changed
    end            
    it "should be true if smtp_password is chnaged" do
      @prefs.smtp_password = "my_password"
      @prefs.should be_smtp_prefs_changed
    end            
    it "should not be true if site_name is changed" do
      @prefs.site_name = "Some Site Name"
      @prefs.should_not be_smtp_prefs_changed      
    end
  end
  
end

# == Schema Information
#
# Table name: preferences
#
#  id                    :integer(4)      not null, primary key
#  domain                :string(255)
#  site_name             :string(255)
#  smtp_server           :string(255)
#  smtp_port             :integer(4)
#  smtp_uses_tls         :boolean(1)
#  smtp_username         :string(255)
#  smtp_password         :string(255)
#  upload_notifications  :boolean(1)      default(TRUE)
#  admin_email           :string(255)
#  from_email            :string(255)
#  email_subject_prefix  :string(255)
#  allow_password_resets :boolean(1)      default(TRUE)
#  require_ssl           :boolean(1)
#  maximum_file_size     :integer(4)
#  analytics             :text
#  logo_url              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  google_tracking_code  :string(255)
#  google_analytics_type :string(255)
#

