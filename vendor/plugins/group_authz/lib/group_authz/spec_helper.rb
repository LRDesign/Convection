module GroupAuthz
  module Matcher
    class Authorized
      def initialize
        @controller = nil
      end

      MatchState = "authorized"

      def check_authorization_flag
        return false unless @controller.flash.has_key?(:group_authorization)
        return false unless @controller.flash[:group_authorization] == true
        return true
      end

      def matches?(controller)
        @controller = controller
        #controller should be a controller
        return check_authorization_flag
      end

      def failure_method_for_should
        "Expected #{@controller.inspect} to be #{MatchState}, but flash[:group_authorization] is #{@controller.flash[:group_authorization]}"
      end

      def failure_method_for_should_not
        "Expected #{@controller.inspect} to be #{MatchState}, but flash[:group_authorization] is #{@controller.flash[:group_authorization]}"
      end
    end

    class Allowed < Authorized
      MatchState = "allowed"

      def check_authorization_flag
        return false if @controller.flash[:group_authorization] == false
        return true #nil is okay
      end
    end

    class Forbidden < Authorized
      MatchState = "forbidden"

      def check_authorization_flag
        return true if @controller.flash[:group_authorization] == false
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

    def be_allowed
      return Matcher::Allowed.new
    end
  end
end

module Spec::Rails::Example::ControllerExampleGroup
  class << self
    include GroupAuthz::ControllerExampleGroupMixin
  end
end
