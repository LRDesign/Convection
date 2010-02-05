unless test?
  prefs = do 
    Preference.find(:first)
  rescue ActiveRecord::RecordNotFound
    puts "Not initializing SMTP; Preferences do not exist yet."
    nil
  end                           
  
  unless prefs.nil?
    set_smtp_preferences(prefs)
  end
end

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
           