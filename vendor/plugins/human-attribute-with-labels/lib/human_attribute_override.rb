# HumanAttributeOverride

module ActiveRecord
  class Base
    class <<self
      # Allows alternate humanized versions of attributes to be set.  For example, an attribute such as 'num_employees' would be
      # converted to 'Num employees' normally using <tt>human_attribute_name</tt>.  More descriptive text can be set. Example:
      #   attr_human_name 'num_employees' => 'Number of employees'
      def attr_human_name(attributes) # :nodoc:
        return unless table_exists?

        attributes.stringify_keys!
        write_inheritable_hash("attr_human_name", attributes || {})

        # assign the current class to each column that is being assigned a new human attribute name
        self.columns.reject{|c| !attributes.has_key?(c.name)}.each{|c| c.parent_record_class = self}
      end

      # Returns a hash of alternate human name conversions set with <tt>attr_human_name</tt>.
      def human_name_attributes # :nodoc:
        read_inheritable_attribute("attr_human_name")
      end

      # Transforms attribute key names into a more humane format, such as "First name" instead of "first_name". Example:
      #   Person.human_attribute_name("first_name") # => "First name"
      def human_attribute_name(attribute_key_name) #:nodoc:
        (read_inheritable_attribute("attr_human_name") || {})[attribute_key_name.to_s] || attribute_key_name.to_s.humanize
      end
    end
  end

  module ConnectionAdapters #:nodoc:
    # An abstract definition of a column in a table.
    class Column
      # the active record class that this column is associated with
      attr_accessor :parent_record_class

      def human_name
        (@parent_record_class || Base).human_attribute_name(@name)
      end
    end
  end
end
