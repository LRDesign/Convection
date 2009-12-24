require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Document do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :data_update_at => Time.now,
      :user_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    # Document.create!(@valid_attributes)
  end
end
