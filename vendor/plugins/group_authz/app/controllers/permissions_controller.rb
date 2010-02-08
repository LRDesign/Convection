class PermissionsController < AuthzController                
  unloadable 
  needs_authorization
  admin_authorized

  def create
    group = Group.find_by_id(params[:group])
    return if group.nil?

    permission_selector = {
      :controller => params[:p_controller], 
      :action => params[:p_action], 
      :subject_id => params[:object], 
      :group => group
    }

    if params["permission"] == "true"
      Permission.create!(permission_selector)
    else
      perms = group.permissions.find(:all, :conditions => permission_selector)
      perms.each {|perm| perm.destroy}
    end

    respond_to do |format|
      format.js 
      format.html do
        redirect_to :back
      end
    end
  end
end
