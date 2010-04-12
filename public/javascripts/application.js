// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



// if this is the iframe
// reload the parent
Event.observe(window, 'load',
  function() {
    try
    {
      if (self.parent.frames.length != 0) {
    		self.parent.location=document.location;
      }
    }
    catch (Exception) {}
  }
);