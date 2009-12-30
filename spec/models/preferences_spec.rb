require 'spec_helper'

describe Preferences do
  before(:each) do
    @valid_attributes = {
      :domain => "value for domain",
      :site_name => "value for site_name",
      :smtp_server => "value for smtp_server",
      :smtp_port => 1,
      :smtp_uses_ssl => false,
      :smtp_username => "value for smtp_username",
      :smtp_password => "value for smtp_password",
      :email_notifications => false,
      :analytics => "value for analytics",
      :logo_url => "value for logo_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Preferences.create!(@valid_attributes)
  end
end
