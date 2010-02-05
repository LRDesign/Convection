class PermissionsController < AuthzController
  needs_authorization

  def create
    group = params[:group]
    return if Group.find_by_id(group).nil?

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
      format.js do       
        render :update do |page|
          page.replace_html :pages_permissions, :partial => 'pages/admin_tools', :locals => { :page => page } 
        end 
      end
      format.html do
        redirect_to :back
      end
    end
  end
end
