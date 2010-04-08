PASSWORD = "foobar"

# TODO create default groups
puts "Seeding database...."

admin_group = Group.create!( :name => "Administration" )            
all_users_group = Group.create!( :name => "All Users" )

admin_user = User.create!(
  :login => "admin",
  :email => "admin@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "Administrator"
)     

admin_user.groups << admin_group
admin_user.groups << all_users_group
admin_user.save

regular_user = User.create!(
  :login => "user",
  :email => "user@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "John Q. User"
)

regular_user.groups << all_users_group
regular_user.save                                    

Preferences.create!(
  :domain => "your_site_domain.com",
  :site_name => "Convection: File Exchange Made Easy",
  :logo_url => "/images/convection_logo.png",
  :smtp_server => "smtp.example.com",
  :smtp_port => 25,
  :smtp_uses_tls  => false,
  :allow_password_resets => true,
  :upload_notifications => true,
  :admin_email => "admin@your_site_domain.com",
  :from_email => "system@your_site_domain.com",  
  :maximum_file_size => 100,      # Megabytes    
  :require_ssl => false,           # Site doesn't require SSL connections
  :google_analytics_type => ''
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

    all_users_group = Group.first(:conditions => {:name => "All Users"})
    #create_permission(admin, "admin/permissions")
    create_permission(all_users_group, "documents", "new")
  end
end

puts "Seeding done.  Users: #{User.count} Groups: #{Group.count} Permissions: #{Permission.count} Preferences: #{Preferences.count}"
