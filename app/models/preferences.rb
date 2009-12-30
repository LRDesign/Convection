# == Schema Information
#
# Table name: preferences
#
#  id                  :integer(4)      not null, primary key
#  domain              :string(255)
#  site_name           :string(255)
#  smtp_server         :string(255)
#  smtp_port           :integer(4)
#  smtp_uses_ssl       :boolean(1)
#  smtp_username       :string(255)
#  smtp_password       :string(255)
#  email_notifications :boolean(1)
#  analytics           :text
#  logo_url            :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class Preferences < ActiveRecord::Base
end
