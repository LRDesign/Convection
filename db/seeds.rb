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

Preferences.create!(
  :domain => "your_site_domain.com",
  :site_name => "Convection: File Exchange Made Easy",
  :logo_url => "/images/convection_logo.png",
  :smtp_server => "smtp.example.com",
  :smtp_port => 25,
  :smtp_uses_tls  => false,
  :allow_password_resets => true,
  :email_notifications => true,
  :maximum_file_size => 100,      # Megabytes    
  :require_ssl => false           # Site doesn't require SSL connections
)

admin = Group.create!(
  :name => "Administration"
)

module GroupAuthz
  module PermissionSeeds
    def self.create_permission(user, controller, action = nil, subject_id = nil)
      GroupAuthz::Permission.create!(
        :group_id => user.id,
        :controller => controller,
        :action => action,
        :subject_id => subject_id
      )
    end

    #create_permission(admin, "admin/permissions")
  end
end
