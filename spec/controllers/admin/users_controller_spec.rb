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
  describe "GET show" do
    it "should find the user" do
      get :show, :id => @user
      assigns[:user].should == @user
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
  # describe "DELETE destroy" do
  #   it "should destroy the requested user" do
  #     User.should_receive(:find).with(@user.id).and_return(@user)
  #     @user.should_receive(:destroy)
  #     debugger
  #     delete :destroy, :id => @user.id
  #   end
  # 
  #   it "should redirect to the users list" do
  #     delete :destroy, :id => @user.id
  #     response.should redirect_to(users_url)
  #   end
  # end
  
  def valid_params
    {
      :name => "Joe Schmoe",
      :login => "joe",
      :email => 'joe@example.com',
      :admin => 'false',
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

end
