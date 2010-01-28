require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  before(:each) do
    activate_authlogic
  end


  describe "responding to GET edit" do
    before(:each) do
      @user = Factory(:user)
      login_as @user
    end
    
    it "should expose the requested user as @user" do
      get :edit, :id => @user.id
      assigns[:user].should == @user
    end

  end

  describe "responding to PUT update" do

    before(:each) do   
      @user = Factory.create(:user)
      login_as @user
    end                  

    describe "with valid params" do
      it "should expose the requested user as @user" do
        put :update, :id => @user.id, :user => { :name => 'foobar' }
        assigns(:user).should == @user
      end

      it "should redirect to the edit page" do
        put :update, :id => @user.id, :user => { :name => 'foobar' } 
        response.should redirect_to(edit_user_url(@user))
      end                         
      
      it "should make the requested changes" do
        lambda do 
          put :update, :id => @user.id, :user => { :name => 'foobar' }          
          @user.reload
        end.should change(@user, :name).to('foobar')
      end

    end
    
    describe "with invalid params" do
      it "should expose the user as @user" do
        put :update, :id => @user.id, :user =>  { :name => nil }
        assigns(:user).should == @user
      end

      it "should re-render the 'edit' template" do
        put :update, :id => @user.id, :user => { :name => nil } 
        response.should render_template('edit')
      end

    end

  end


end
