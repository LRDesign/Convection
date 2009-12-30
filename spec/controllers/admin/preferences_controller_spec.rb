require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PreferencesController do
  fixtures :preferences
  
  before(:each) do
    activate_authlogic
    login_as(Factory(:admin))
  end
  
  ###################################################################################  
  # GET edit
  ###################################################################################  
  describe "GET edit" do
    it "should find the preferences" do
      get :edit
      assigns[:preferences].should == Preferences.find(:first)
    end

    it "should render the edit template" do
      get :edit
      response.should render_template(:edit)
    end
  end  
  
  ###################################################################################  
  # PUT update
  ###################################################################################  
  describe "PUT update" do
    before(:each) do
      @preferences = Preferences.find(:first)
    end

    it "should find the preferences" do
      put :update, :preferences => { :site_name => 'Foobar' }
      assigns[:preferences].should == @preferences
    end
    
    describe "with valid params" do
      it "should update the preferences" do        
        lambda do
          put :update, :preferences => { :site_name => 'Foobar' }
          @preferences.reload
        end.should change(@preferences, :site_name).to('Foobar')
      end
      it "should redirect to the edit page" do
        put :update, :preferences => { :site_name => 'Foobar' }
        response.should redirect_to(edit_admin_preferences_url)
      end
    end
    
    describe "with invalid params" do
      it "should not update the preferences" do
        lambda do
          put :update, invalid_params
          @preferences.reload
        end.should_not change(@preferences, :site_name)
      end
      
      it "should re-render the edit template" do
        put :update, invalid_params
        response.should render_template(:edit)
      end
    end
  end  
  
  
  def invalid_params
    {:preferences => { :site_name => 'Foobar', :email_notifications => true, :smtp_server => nil }}
  end

end
