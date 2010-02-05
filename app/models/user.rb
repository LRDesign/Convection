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

class User < ActiveRecord::Base   

  acts_as_authentic do |c|
    c.session_class = UserSession
  end  
  validates_presence_of :name, :email
  
  has_and_belongs_to_many :groups
  has_many :documents

  def admin?
    groups.include? Group.admin_group
  end

  def admin
    return admin?
  end

  def display_name
    name.blank? ? login : name
  end  
         
  # returns true if the user can do *action* on *document*
  def can?(action, document)
    return true if self == document.user or self.admin?
    groups.any? do |group|
      !Permission.find(:first, :conditions => 
        { :controller => 'documents',
          :group_id => group.id,
          :action => action.to_s,
          :subject_id => document.id
        }
      ).nil?    
    end
  end
end
