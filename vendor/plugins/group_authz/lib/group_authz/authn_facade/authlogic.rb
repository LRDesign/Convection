if defined? GroupAuthz::AuthnFacade
  warn "group_authz authentication facade (GroupAuthz::AuthnFacade) already defined - not redefining."
else
  module GroupAuthz
    class AuthnFacade
      def self.current_user(controller)
        #This assumes authlogic is implemented as recommended - otherwise 
        #you'll need to develop your own AuthnFacade
        return controller.__send__(:current_user)
      end
    end
  end
end
