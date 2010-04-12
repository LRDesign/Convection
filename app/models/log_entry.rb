class LogEntry < ActiveRecord::Base
  belongs_to :user
  serialize :details
  
  def is_update_action?
    self.action == 'update'   
  end  
end
