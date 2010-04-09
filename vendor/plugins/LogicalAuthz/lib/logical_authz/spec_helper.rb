module LogicalAuthz
  module Matcher
    class Authorized
      def initialize
        @controller = nil
      end

      def match_state
        "authorized"
      end

      def check_authorization_flag
        return true if @flash[:group_authorization] == true
        return false
      end

      def matches?(controller)
        @controller = controller
        @flash = controller.__send__(:flash)
        #controller should be a controller
        return check_authorization_flag
      end

      def failure_message_for_should
        "Expected #{@controller.class.name}(#{@controller.params.inspect}) to be #{match_state}, but flash[:group_authorization] is <#{@flash[:group_authorization].inspect}>"
      end

      def failure_message_for_should_not
        "Expected #{@controller.class.name}(#{@controller.params.inspect}) not to be #{match_state}, but flash[:group_authorization] is <#{@flash[:group_authorization].inspect}>"
      end
    end

    class Forbidden < Authorized
      def match_state
        "forbidden"
      end

      def check_authorization_flag
        return true if @flash[:group_authorization] == false
        return false
      end
    end
  end


  module ControllerExampleGroupMixin
    def be_authorized
      return Matcher::Authorized.new
    end

    def be_forbidden
      return Matcher::Forbidden.new
    end
  end
end

module Spec::Rails::Example
  class ControllerExampleGroup
    include LogicalAuthz::ControllerExampleGroupMixin
  end
end
