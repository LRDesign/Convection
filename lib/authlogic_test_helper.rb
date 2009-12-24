module AuthlogicTestHelper
    
    def current_user(stubs = {})
      current_user_session.person
    end
    
    alias :current_person :current_user
    
    def current_user_session(stubs = {}, user_stubs = {}) 
      @current_user_session = UserSession.find
      # else  
      #   @current_user_session ||= mock_model(UserSession, {:person => current_user(user_stubs)}.merge(stubs))
      # end  
    end    
    
    def login_as(person)
      person = people(person) if person.is_a?(Symbol)
      @current_session = UserSession.create(person)
      person
    end
    
    def logout
      @current_user_session = nil
    end
end
