module SMTPSystem
  
  def set_smtp_preferences(prefs)
    require 'tlsmail'

    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE) if prefs.smtp_uses_tls?

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :address        => prefs.smtp_server,
      :port           => prefs.smtp_port,
      :domain         => prefs.domain,
      :authentication => :login,
      :user_name      => prefs.smtp_username,
      :password       => prefs.smtp_password 
    }  
  end

end
