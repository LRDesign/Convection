# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper      
                                               
  # same function as application_controller.rb's logged_in? method
  def logged_in?
    !current_user.nil?
  end                
  
  def delete_widget(object, options = {})
    link_to image_tag('delete.png'), (options[:path] || object), :confirm => 'Are you sure?', :method => :delete, :title => "Delete #{object.class}"       
  end
  
  def edit_widget(object, options = {})
    link_to image_tag('edit.png'), (options[:path] || edit_polymorphic_path(object)), :title => "Edit #{object.class}"        
  end
  
  # returns a hash showing the changes between the before/after states
  # of two activerecord objects.  If both before and after are specified,
  # it should return a hash formatted like "object.changes", otherwise,
  # it should just return the attribute hash of whichever one wasn't nil
  def loggable_details(before, after)
    map = {}
    if (!before.nil? && !after.nil?)
      merged_keys = before.attributes.merge(after.attributes).keys
      merged_keys.each do |key| 
        if (before[key] != after[key])
          map.merge!({ key => [before[key], after[key]]})     
        end 
      end
    elsif(before || after) 
      item = before || after
      item.attributes.each do |key, val| 
        # only include non-nil attributes
        map.merge!({ key => item[key]}) if !val.nil?
      end
    end            
    map
    
  end  

                                 
end
