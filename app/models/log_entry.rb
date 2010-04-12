class LogEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  serialize :details
  
  def is_update_action?
    self.action == 'update'   
  end  
end


# == Schema Information
#
# Table name: log_entries
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  action      :string(255)
#  document_id :integer(4)
#  details     :text
#  created_at  :datetime
#  updated_at  :datetime
#

