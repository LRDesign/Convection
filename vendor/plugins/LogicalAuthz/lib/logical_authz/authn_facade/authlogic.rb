if defined? LogicalAuthz::AuthnFacade
  warn "logical_authz authentication facade (LogicalAuthz::AuthnFacade) already defined - not redefining."
else
  module LogicalAuthz
    class AuthnFacade
      def self.current_user(controller)
        #This assumes authlogic is implemented as recommended - otherwise 
        #you'll need to develop your own AuthnFacade
        return controller.current_user
      end
    end
  end
end
