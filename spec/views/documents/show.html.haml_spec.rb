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
    assigns[:preferences] = Factory(:preferences, :google_tracking_code => 'UA-foobar', :google_analytics_type => 'Traditional')
    render "/documents/show.html.haml", :layout => 'application'
    response.should have_tag("body", :text => /UA-foobar/) do
      with_tag("script", :text => /gaJsHost/) 
    end
  end

  it "should include asynchronous analytics code if the preferences are set" do
    assigns[:preferences] = Factory(:preferences, :google_tracking_code => 'UA-foobar', :google_analytics_type => 'Asynchronous')
    render "/documents/show.html.haml", :layout => 'application'
    response.should have_tag("head", :text => /UA-foobar/) do
      with_tag("script", :text => /_gaq/) 
    end
  end
  
end

