class Admin::PreferencesController < Admin::AdminController
  before_filter :find_prefs
        
  # GET /admin/preferences/edit
  def edit
    @user = User.new

    respond_to do |format|
      format.html 
    end
  end

  # PUT /admin/preferences
  def update
  end
  
  
  private
  def find_prefs
    @preferences = Preferences.find(:first)
  end
  
end
