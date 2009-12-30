require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  before(:each) do
    @user = Factory(:user)
  end

  describe "responding to GET index" do

    it "should expose all users as @users" do
      get :index
      assigns[:users].should == User.find(:all)
    end

    describe "with mime type of xml" do
  
      it "should render all users as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        User.should_receive(:find).with(:all).and_return(users = mock("Array of Users"))
        users.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested user as @user" do
      get :show, :id => @user.id
      assigns[:user].should == @user
    end
    
    describe "with mime type of xml" do

      it "should render the requested user as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        User.should_receive(:find).with("37").and_return(@user)
        @user.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

 

  describe "responding to GET edit" do
  
    it "should expose the requested user as @user" do
      get :edit, :id => @user.id
      assigns[:user].should == @user
    end

  end

  describe "responding to PUT update" do

    before(:each) do
      User.should_receive(:find).with(@user.id).and_return(@user)
    end

    it "should update the requested user" do
      @user.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => @user.id, :user => {:these => 'params'}
    end

    describe "with valid params" do

      before(:each) do
        @user.stub!(:update_attributes => true)
      end

      it "should expose the requested user as @user" do
        put :update, :id => @user.id
        assigns(:user).should equal(@user)
      end

      it "should redirect to the user" do
        put :update, :id => @user.id
        response.should redirect_to(user_url(@user))
      end

    end
    
    describe "with invalid params" do

      before(:each) do
        @user.stub!(:update_attributes => false)
      end

      it "should expose the user as @user" do
        put :update, :id => @user.id
        assigns(:user).should equal(@user)
      end

      it "should re-render the 'edit' template" do
        put :update, :id => @user.id
        response.should render_template('edit')
      end

    end

  end


end
