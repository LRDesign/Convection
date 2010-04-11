require 'spec_helper'

describe LogEntry do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :action => "value for action",
      :created_at => Time.now,
      :updated_at => Time.now,
      :item_type => "value for item_type",
      :source_id => 1,
      :table => "value for table",
      :details => "value for details"
    }
  end

  it "should create a new instance given valid attributes" do
    LogEntry.create!(@valid_attributes)
  end
end
