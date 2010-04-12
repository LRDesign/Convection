require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocumentsHelper do
  
  describe "truncate_filename" do
    before(:each) do
      @long = "ThisIsAReallyLongFilenameWithTooMuchTextSoItBreaksWrapping.txt"
    end
    it "should leave short filenames intact" do
      helper.truncate_filename('ShortFile.txt').should == 'ShortFile.txt'  
    end
    it "should shorten really long filenames" do
      helper.truncate_filename(@long).should_not == @long
      helper.truncate_filename(@long).length.should < @long.length
    end
    it "should keep the extension intact on long filename" do
      helper.truncate_filename(@long).split('.')[1].should == 'txt'
    end
  end
  
end
