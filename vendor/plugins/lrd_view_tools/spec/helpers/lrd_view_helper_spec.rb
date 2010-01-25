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
        helper.bool_checked(false).should =~ /images\/spacer.gif/        
      end
    end
  end   
  
   
end