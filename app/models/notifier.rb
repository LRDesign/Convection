class Notifier < ActionMailer::Base
  
  def upload_notification(document)
    recipients site_preferences.admin_email
    from       site_preferences.from_email 
    subject    formatted_subject("Upload Notifications")
    body       :document => document
  end
  
  def download_notification(document, downloader)
    recipients site_preferences.admin_email
    from       site_preferences.from_email 
    subject    formatted_subject("Download Notifications")
    body       :document => document,
               :downloader => downloader
  end
  
  def password_reset_instructions(user) 
    subject     "Password Reset Instructions"
    from        "Binary Logic Notifier " 
    recipients  user.email 
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def formatted_subject(subject)
    if site_preferences.email_subject_prefix
      "#{site_preferences.email_subject_prefix} #{subject}"
    else
      subject
    end
  end         
  
  private
  def site_preferences
    @prefs = Preferences.find(:first)
  end
  
end
