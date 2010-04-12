class UsersController < ApplicationController                           
  before_filter :require_user
  before_filter :find_user, :only => [ :edit, :update ]
                                                                
  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Settings updated.'
        format.html { redirect_to(edit_user_path(@user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  private  
  def find_user
    @user = User.find(params[:id])
    raise ArgumentError, 'Invalid user id provided' unless @user
  end
end
