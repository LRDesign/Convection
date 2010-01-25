require File.dirname(__FILE__) + '/../spec_helper'
require 'lib/lrd_view_helper'

describe LRD::ViewHelper do
  
  describe "bool_checked" do
    describe "with true" do
      it "should return an image tag for the checkmark" do
        helper.bool_checked(true).should =~ /images\/check.png/
      end
    end
    describe "with false" do
      it "should return an image tag for a spacer" do
        helper.bool_checked(false).should =~ /images\/blank.gif/        
      end
    end
  end   
                 
  describe "labeled_input" do
    before(:each) do
      @form = mock(ActionView::Helpers::FormHelper)
      @form.stub!(:text_field).and_return("<input name='field' />")
      @form.stub!(:label).and_return("<label for='field'>")
      
      @labeled_input = helper.labeled_input(@form, :field)
    end
    
    it "should return a string" do  
      @labeled_input.is_a?(String).should be_true
    end
    it "should contain the input tag" do
      @labeled_input.should match(/<input/)
      @labeled_input.should match(/name='field'/)
    end               
    it "should contain the label tag field" do
      @labeled_input.should match(/<label/)
      @labeled_input.should match(/for='field'/)
    end
    
  end                 
                 
   
end