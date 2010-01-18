module GroupAuthz
  module AuthnFacade
    @@current_user = nil

    def self.current_user
      @@current_user
    end

    def self.current_user=(user)
      @@current_user = user
    end
  end

  module MockAuth
    def logout
      AuthnFacade.current_user = nil
    end

    def login_as(user)
      AuthnFacade.current_user = az_accounts(user)
    end
  end
end
