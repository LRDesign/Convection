module LRD
  module ViewHelper                                  

    # Stores a headline for later rendering by the layout
    def set_headline(headline)
      content_for(:headline, headline)
    end              

    # displays a checkmark if the field is set true
    def bool_checked(field)
      filename = field ? "check.png" : "blank.gif"
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
    
    # a standardized view helper that renders a box with an optional
    # title.   The standard partial for it is in views/shared/_page_block.html.haml
    def page_block(title = nil, options = {}, &block)
      block_to_partial('shared/block', options.merge(:title => title), &block)
    end
    
          
    # pass { :nolabel => true } to replace the label with a spacer   
    # pass { :required => true } to dispay as a required field  
    # pass { :text => "foo" } to override the label text
    def labeled_input(form, field, options = {}) 
      options[:text] = "&nbsp;" if options[:nolabel]
      options.reverse_merge!(:text => nil, :size => 30, :required => false, :nolabel => false)
      options.merge!(:form => form, :field => field)     

      cssclass = "labeled_input"
      cssclass += " required" if options[:required]

      # debugger

      unless input = options[:input]
        input = form.text_field field, :size => options[:size]
      end

      label = form.label field, options[:text]      
      comment = options[:comment] ? content_tag( :span, { :class => 'comment' } ) { options[:comment] }  : ""

      # debugger
      content_tag :div, { :class => cssclass } do
        label + input + comment 
      end              
    end          

  end
end               
              
