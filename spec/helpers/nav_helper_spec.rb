require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NavHelper do
   
   describe "menu item" do
     before(:each) do
       @item = helper.menu_item("Item Text", "path/name") 
     end
     it "should generate an <li> for the item" do
       @item.should have_tag("li.unselected")
     end
     it "should generate a link to the path" do
       @item.should have_tag("a[href=?]", "path/name")
     end
     it "should set li class to 'selected' if this is the current path" do
       helper.stub!(:current_page?).and_return(true)
       @item = helper.menu_item("Item Text", "path/name")        
       @item.should have_tag("li.selected")       
     end
   end
    
end
