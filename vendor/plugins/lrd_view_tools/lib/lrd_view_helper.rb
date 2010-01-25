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


    # Passes the supplied block to the named partial
    def block_to_partial(partial_name, options = {}, &block)    
      # replace :id with :cssid and :class with :cssclass
      if options[:id]
        options[:cssid] = options.delete(:id)
      else
        options[:cssid] = "" if options[:cssid].nil?
      end
      if options[:class]
        options[:cssclass] = options.delete(:class) 
      else
        options[:cssclass] = "" if options[:cssclass].nil?    
      end   
    
      options.merge!(:body => capture(&block))
      concat(render(:partial => partial_name, :locals => options))
    end    
          
    # pass { :nolabel => true } to replace the label with a spacer   
    # pass { :required => true } to dispay as a required field  
    # pass { :text => "foo" } to override the label text
    def labeled_input(form, field, options = {}) 
      options[:text] = "&nbsp;" if options[:nolabel]
      options.reverse_merge!(:text => nil, :size => nil, :required => false, :nolabel => false)
      options.merge!(:form => form, :field => field)     
      
      cssclass = "labeled_input"
      cssclass += " required" if options[:required]
      
      input ||= capture do                                                
        if options[:size].blank?
          form.text_field field 
        else
          form.text_field field, :size => options[:size]
        end
      end  
      
      label = form.label field, options[:text]
      
      comment = options[:comment] ? content_tag( :span, { :class => 'comment' } ) { options[:comment] }  : ""
      
      content_tag :div, { :class => cssclass } do
        label + input + comment 
      end  
              
    end
  end
end               
              
