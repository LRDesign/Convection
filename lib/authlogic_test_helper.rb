module AuthlogicTestHelper
    
    def current_user(stubs = {})
      current_user_session.user
    end
    
    alias :current_person :current_user
    
    def current_user_session(stubs = {}, user_stubs = {}) 
      @current_user_session = UserSession.find
      # else  
      #   @current_user_session ||= mock_model(UserSession, {:person => current_user(user_stubs)}.merge(stubs))
      # end  
    end    
    
    def login_as(user)
      user = users(user) if user.is_a?(Symbol)
      @current_session = UserSession.create(user)
      user
    end
    
    def logout
      @current_user_session = nil
      UserSession.find.destroy if UserSession.find
    end
end
