require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do

  before(:all) do
    @user = Factory.create(:user)    
  end
  
  before(:each) do
    activate_authlogic
    login_as(Factory(:admin))
  end

  describe "authorization" do
    it "should deny access to regular user" do
      logout
      login_as(@user)
      get :index
      response.should be_redirect
      flash[:error].should_not be_nil
    end
    it "should allow access to admin user" do
      get :index
      response.should be_success
    end
  end
    
  ###################################################################################  
  # GET index
  ###################################################################################  
  describe "GET index" do
    it "should expose the list of users in an instance variable" do
      get :index
      assigns[:users].should == User.find(:all)
    end
  end   
     
  ###################################################################################  
  # GET show
  ###################################################################################  
  describe "GET index" do
    it "should redirect to the edit page" do
      get :show, :id => @user.id
      response.should redirect_to(edit_admin_user_path(@user))
    end
  end
  
  ###################################################################################  
  # GET new
  ###################################################################################    
  describe "GET new" do
     it "should expose a new user as @user" do
       user = Factory.build(:user)
       User.should_receive(:new).and_return(user)
       get :new
       assigns[:user].should equal(user)
     end

   end

   ###################################################################################  
   # GET edit
   ###################################################################################    
   describe "GET edit" do
     before(:each) do
       @user = Factory.create(:user)       
     end
      it "should find and expose the user as @user" do
        get :edit, :id => @user.id
        assigns[:user].should == @user
      end

    end


  ###################################################################################  
  # PUT update
  ###################################################################################  
  describe "PUT update" do
    before(:each) do
      @user = Factory.create(:user, { :login => "original_name "})
    end
    
    describe "with valid params" do
      it "should succeed" do
        put :update, :id => @user.id, :user => { :login => "new_name" }
        response.should be_success
      end
      
      it "should expose the correct user as @user" do
        put :update, :id => @user.id, :user => { :login => "new_name" }
        assigns[:user].should == @user
      end
      
      it "should have a success flash message" do
        put :update, :id => @user.id, :user => { :login => "new_name" }
        flash[:success].should_not be_nil
      end
      
      it "should update the user record" do
        lambda do  
          put :update, :id => @user.id, :user => { :login => "new_name" }
          @user.reload
        end.should change{ @user.login }.to("new_name")
      end
      
      it "should re-render the edit page" do
        put :update, :id => @user.id, :user => { :login => "new_name" }
        response.should render_template(:edit)       
      end
    end    
  end

   
  ###################################################################################  
  # POST create
  ###################################################################################  
  describe "POST create" do
    before(:each) do
      @new_user = Factory.build(:user)
    end

    describe "with valid params" do
      it "should create a new user in the DB" do
        lambda do 
          post :create, :user => valid_params
        end.should change(User, :count).by(1)
      end

      it "should redirect to the created user" do
        User.stub!(:new).and_return(@new_user)
        post :create, :user => valid_params
        response.should redirect_to(user_url(@new_user))
      end
    end
    
    describe "with invalid params" do
    
      before(:each) do
        @new_user.stub!(:save => false)
      end
    
      it "should not create a new user in the DB" do
        lambda do 
          post :create, :user => valid_params.merge!(:login => nil)
        end.should_not change(User, :count).by(1)        
      end
      
      it "should expose a newly created but unsaved user as @user" do
        User.stub!(:new).with({'these' => 'params'}).and_return(@new_user)
        post :create, :user => {:these => 'params'}
        assigns(:user).should equal(@new_user)
      end
    
      it "should re-render the 'new' template" do
        User.stub!(:new).and_return(@new_user)
        post :create, :user => {}
        response.should render_template('new')
      end
    end
  end
  
  
  ###################################################################################  
  # DELETE destroy
  ###################################################################################  
  describe "DELETE destroy" do
    before(:each) do
      @destroyable_user = Factory.create(:user)
      User.find(@destroyable_user.id).should == @destroyable_user
    end
    
    it "should destroy the requested user" do
      delete :destroy, :id => @destroyable_user.id
      lambda { User.find(@destroyable_user.id) }.should raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should reduce the number of users by one" do
      lambda {delete :destroy, :id => @destroyable_user.id}.should change(User, :count).by(-1)
      
    end
  
    it "should redirect to the users list" do
      delete :destroy, :id => @destroyable_user.id
      response.should redirect_to(admin_users_url)
    end
  end
  
  def valid_params
    {
      :name => "Joe Schmoe",
      :login => "joe",
      :email => 'joe@example.com',
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

end
