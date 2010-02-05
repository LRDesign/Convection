include SMTPSystem

unless env.test?
  begin 
     prefs = Preferences.find(:first)
  rescue ActiveRecord::RecordNotFound
    puts "Not initializing SMTP; Preferences do not exist yet."
    nil
  end                           
  
  unless prefs.nil?
    set_smtp_preferences(prefs)
  end
end
  