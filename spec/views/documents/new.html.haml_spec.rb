require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/new.html.haml" do
  include DocumentsHelper
  
  before(:each) do
    assigns[:document] = Factory.build(:document)
  end

  it "should render new form" do
    render "/documents/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", documents_path) do
      with_tag("input#document_name[name=?]", "document[name]")
      with_tag("textarea#document_description[name=?]", "document[description]")
    end
  end
end


