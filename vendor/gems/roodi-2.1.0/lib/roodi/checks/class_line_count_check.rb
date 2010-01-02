require 'roodi/checks/line_count_check'

module Roodi
  module Checks
    # Checks a class to make sure the number of lines it has is under the specified limit.
    # 
    # A class getting too large is a code smell that indicates it might be taking on too many 
    # responsibilities.  It should probably be refactored into multiple smaller classes. 
    class ClassLineCountCheck < LineCountCheck
      DEFAULT_LINE_COUNT = 300
      
      def initialize(options = {})
        line_count = options['line_count'] || DEFAULT_LINE_COUNT
        super([:class], line_count, 'Class')
      end
    end
  end
end
