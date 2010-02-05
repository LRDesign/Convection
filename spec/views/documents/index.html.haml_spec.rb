require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/index.html.haml" do
  include DocumentsHelper
  
  before(:each) do
    # @data = mock_model(Paperclip::Attachment, :null_object => true, :url => "http://example.com/foo.jpg")
    # doc = Factory(:document)
    # doc.stub!(:data).and_return(@data)   
    activate_authlogic                
    login_as Factory(:user)
    assigns[:documents] = [ Factory(:document), Factory(:document) ]
  end

  it "should succeed" do
    render "/documents/index.html.haml"
    response.should be_success
  end
end

