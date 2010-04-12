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

class Preferences < ActiveRecord::Base
  SMTP_PREFS = [ :smtp_server, :smtp_port, :smtp_uses_tls, :smtp_username, :smtp_password ]  
  GOOGLE_ANALYTICS_TYPES = [ '', "Traditional", "Asynchronous" ] 

  validates_presence_of :domain,       :if => :using_email?
  validates_presence_of :smtp_server,  :if => :using_email?
  validates_presence_of :admin_email,  :if => :upload_notifications?
  validates_presence_of :from_email,   :if => :using_email?      
  validates_inclusion_of :google_analytics_type, :in => GOOGLE_ANALYTICS_TYPES
  
  attr_human_name  :site_name => "Site Name"
  attr_human_name  :upload_notifications => "Notify Admin?"
  attr_human_name  :logo_url => "Logo URL"
  attr_human_name  :smtp_server => "SMTP Server"
  attr_human_name  :smtp_port  => "SMTP Port"
  attr_human_name  :smtp_uses_tls => "Use TLS"
  attr_human_name  :smtp_username => "SMTP Username"
  attr_human_name  :smtp_password => "SMTP Password"    
  attr_human_name  :require_ssl => "Require SSL"
  attr_human_name  :allow_password_resets => "Allow Resets"
  attr_human_name  :maximum_file_size => "Max. File Size"    
  attr_human_name  :google_tracking_code => "Tracking Code" 
  attr_human_name  :google_analytics_type => "Analytics Type" 
                      
  
  # returns true if any of the attributes in SMTP_PREFS are dirty
  def smtp_prefs_changed?
    SMTP_PREFS.any? { |p| self.changed.include?(p.to_s)  }
  end
               
  def google_analytics?
    self.google_tracking_code && self.google_analytics_type == 'Traditional'
  end
  def async_analytics?
    self.google_tracking_code && self.google_analytics_type == 'Asynchronous'
  end
                        
  private  
  def using_email?
    upload_notifications || allow_password_resets
  end                   

  def validate              
    if !self.google_tracking_code.blank? && self.google_analytics_type.blank?
      self.errors.add(:google_analytics_type,
        "must be selected if you enter a tracking code.")
    end
  end
  
end

