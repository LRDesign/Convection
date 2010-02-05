require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe "/uploads/index" do
  before(:each) do
    assigns[:documents] = [
      Factory.create(:document),
      Factory.create(:document)
      ]
    render 'uploads/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should succeed" do
    response.should be_success
  end
end
