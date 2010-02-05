class GroupsUsersController < AuthzController
  before_filter :get_instance_vars
  
  def create
    if @user && @group
      @user.groups << @group
    end 
    respond_to do |format|
      format.html { redirect_to :back }
    end 
  end

  def destroy
    if @user && @group
      @user.groups.delete(@group)
    end 
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
  def get_instance_vars   
    @user = Group.member_class.find_by_id(params[:user_id])
    @group = Group.find_by_id(params[:group_id])     
  end
end
