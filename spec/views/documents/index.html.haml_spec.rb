require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/index.html.haml" do
  include DocumentsHelper
  
  before(:each) do
    assigns[:documents] = [ Factory(:document), Factory(:document) ]
  end

  it "should render list of documents" do
    render "/documents/index.html.haml"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

