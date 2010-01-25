module LRD
  module ViewHelper                                  

    # Stores a headline for later rendering by the layout
    def set_headline(headline)
      content_for(:headline, headline)
    end              

    # displays a checkmark if the field is set true
    def bool_checked(field)
      filename = field ? "check.png" : "spacer.gif"
      image_tag(filename, :alt => "yes", :size => "16x16")   
    end    
  end
end               


