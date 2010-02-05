# == Schema Information
#
# Table name: preferences
#
#  id                    :integer(4)      not null, primary key
#  domain                :string(255)
#  site_name             :string(255)
#  smtp_server           :string(255)
#  smtp_port             :integer(4)
#  smtp_uses_tls         :boolean(1)
#  smtp_username         :string(255)
#  smtp_password         :string(255)
#  email_notifications   :boolean(1)      default(TRUE)
#  allow_password_resets :boolean(1)      default(TRUE)
#  require_ssl           :boolean(1)
#  maximum_file_size     :integer(4)
#  analytics             :text
#  logo_url              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#
class Admin::PreferencesController < Admin::AdminController
  include SMTPSystem                                       

  before_filter :find_prefs
        
  # GET /admin/preferences/edit
  def edit
    respond_to do |format|
      format.html 
    end
  end

  # PUT /admin/preferences
  def update
    @preferences.attributes = params[:preferences]
    
    if @preferences.valid?   
      set_smtp_preferences(@preferences) if @preferences.smtp_prefs_changed?
      @preferences.save
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
