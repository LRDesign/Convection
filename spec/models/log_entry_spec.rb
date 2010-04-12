require 'spec_helper'

describe LogEntry do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :action => "value for action",
      :created_at => Time.now,
      :updated_at => Time.now,
      :document_id => 1,
      :details => "value for details"
    }
  end

  it "should create a new instance given valid attributes" do
    LogEntry.create!(@valid_attributes)
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

