PASSWORD = "foobar"

# TODO create default groups

User.create!(
  :login => "admin",
  :email => "admin@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "Administrator",
  :admin => true  # TODO replace this with admin group membership
)

Preference.create!(
  :site_name => "Convection: File Exchange Made Easy",
  :logo_url => "/images/convection_logo.png",
  :smtp_server => "smtp.example.com",
  :smtp_port => 25,
  :smtp_uses_ssl  => false
)