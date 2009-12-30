class Admin::PreferencesController < Admin::AdminController
  before_filter :find_prefs
        
  # GET /admin/preferences/edit
  def edit
    respond_to do |format|
      format.html 
    end
  end

  # PUT /admin/preferences
  def update
    if @preferences.update_attributes(params[:preferences])
      redirect_to edit_admin_preferences_path
    else
      render :template => 'edit'
    end
  end
  
  
  private
  def find_prefs
    @preferences = Preferences.find(:first)
  end
  
end
