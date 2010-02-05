class Admin::UsersController < Admin::AdminController
  before_filter :find_user, :only => [ :show, :edit, :update, :destroy ]
     
  # GET :index
  def index
    @users = User.find(:all)
  end  
  
  def show
    redirect_to edit_admin_user_path(User.find(params[:id]))
  end
  
  # GET :edit
  def edit
    @user = User.find(params[:id])
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
    @user.groups << Group.find_by_name('All Users')    
    respond_to do |format|
      if @user.save  
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  #PUT /users/1
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      format.html do
        if (@user.update_attributes(params[:user]))    
          flash[:success] = 'User updated.'
        end  
        render :action => 'edit'
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
