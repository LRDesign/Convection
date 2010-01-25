require File.join(File.dirname(__FILE__), "lib", "lrd_view_helper")  
ActionView::Base.send :include, LRD::ViewHelper  
