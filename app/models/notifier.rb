class Notifier < ActionMailer::Base
  
  def upload_notification(document)
    recipients site_preferences.admin_email
    from       site_preferences.from_email
    subject    formatted_subject("Upload Notifications")
    body       :document => document
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
