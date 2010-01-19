PASSWORD = "foobar"

# TODO create default groups

admin_group = Group.create!(
  :name => "Administration"
)

admin_user = User.create!(
  :login => "admin",
  :email => "admin@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "Administrator",
)

admin_user.groups << admin_group
admin_user.save

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
