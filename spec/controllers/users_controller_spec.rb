require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do



  describe "responding to GET show" do
    before(:each) do
      @user = Factory(:user)
    end
    
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
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should expose the requested user as @user" do
      get :edit, :id => @user.id
      assigns[:user].should == @user
    end

  end

  describe "responding to PUT update" do

    before(:each) do
      @user = Factory.create(:user)
    end

    describe "with valid params" do
      it "should expose the requested user as @user" do
        put :update, :id => @user.id, :user => { :name => 'foobar' }
        assigns(:user).should == @user
      end

      it "should redirect to the user" do
        put :update, :id => @user.id, :user => { :name => 'foobar' } 
        response.should redirect_to(user_url(@user))
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
