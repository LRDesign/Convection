require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/show.html.haml" do
  include DocumentsHelper
  
  before(:each) do
    assigns[:document] = @document = Factory(:document)
  end

  it "should render attributes in <p>" do
    render "/documents/show.html.haml"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
end

