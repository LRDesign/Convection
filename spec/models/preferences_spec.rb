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
#  email_notifications   :boolean(1)      default(TRUE)
#  allow_password_resets :boolean(1)      default(TRUE)
#  require_ssl           :boolean(1)
#  maximum_file_size     :integer(4)
#  analytics             :text
#  logo_url              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')    

describe Preferences do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    Factory.create(:preferences)
  end
  
  it "should not be valid if notifications are turned on but no server is set" do
    Factory.build(:preferences, 
      :email_notifications => true, :smtp_server => nil
    ).should_not be_valid
  end
  
end
