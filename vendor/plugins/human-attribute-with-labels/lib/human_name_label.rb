
class ActionView::Helpers::FormBuilder  

  # Overrides label helper to provide humanized caption based on
  # Human Attribute Override plugin.
  #
  # Examples:
  #
  # label @person, :name
  # label :person, :name
  #
  def label_with_human_name(*args)    
    # args[0] is the method, args[1] is the caption
    if object
      args[1] ||= object.class.human_attribute_name(args[0].to_s)
    elsif object_name   
      begin
        klass = eval(object_name.to_s.capitalize)       # transform :person to Person
        args[1] ||= klass.human_attribute_name(args[0])   
      rescue NameError
        # class not identified
      end
    end
    label_without_human_name(*args)
  end
  alias_method_chain :label, :human_name
  
end