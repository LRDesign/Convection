class Admin::UsersController < Admin::AdminController
  before_filter :find_user, :only => [ :show, :edit, :update, :destroy ]
    
  # GET :index
  def index
    @users = User.find(:all)
  end  
    
  # GET :show
  def show
  end
  
  
  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html 
    end
  end
  
  # POST /users
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
    end
  end
  
  
  
  
  private
  def find_user
    @user = User.find(params[:id])
    raise ArgumentError, 'Invalid user id provided' unless @user
  end
  
end
