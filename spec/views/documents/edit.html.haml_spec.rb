require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/edit.html.haml" do
  include DocumentsHelper
  
  before(:each) do                 
    activate_authlogic
    login_as(Factory(:admin))
    assigns[:document] = @document = Factory(:document)
  end

  it "should render edit form" do
    render "/documents/edit.html.haml"
    
    response.should have_tag("form[action=#{document_path(@document)}][method=post]") do
      with_tag('input#document_name[name=?]', "document[name]")
      with_tag('textarea#document_description[name=?]', "document[description]")
    end
  end
end


