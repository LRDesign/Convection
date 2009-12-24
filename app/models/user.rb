class User < ActiveRecord::Base   

  acts_as_authentic do |c|
    #c.session_class = UserSession
  end  
  validates_presence_of :name, :email
  
end
