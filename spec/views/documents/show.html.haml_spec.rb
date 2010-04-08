require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/documents/show.html.haml" do
  include DocumentsHelper
  
  before(:each) do            
    activate_authlogic
    @document = Factory(:document)
    @document.user = Factory(:user)
    assigns[:document] = @document
  end

  it "should render attributes in <p>" do
    render "/documents/show.html.haml"
    response.should have_text(/#{@document.name}/)
    response.should have_text(/#{@document.description}/)
  end        
  
  it "should include google analytics code if the preferences are set" do
    
  end
end

