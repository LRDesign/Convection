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
  
  def change_hash
    {:user_id => id, :login => login, :email => email}
  end
  
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
    # debugger
    return true if self == document.user or self.admin?
    groups.any? {|group|  group.can?(action.to_s, "documents", document ) }
  end           
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end  
end
