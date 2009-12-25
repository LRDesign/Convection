class User < ActiveRecord::Base   

  acts_as_authentic do |c|
    c.session_class = UserSession
  end  
  validates_presence_of :name, :email
  
  # TODO:  implement this based on group membership.
  def admin?
    true    
  end
  
end
