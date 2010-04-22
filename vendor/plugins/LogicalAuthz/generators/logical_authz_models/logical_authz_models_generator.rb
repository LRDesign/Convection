class LogicalAuthzModelsGenerator < LogicalAuthz::Generator
  default_options(:permission_class => "Permission", 
                  :group_class => "Group",
                  :admin_group => "Administration")

  def manifest 
    raise "User class name (--user) is required!" unless options[:user_class]

    record do |manifest|
      #Yeah, I know, and I'm sorry.  It should be okay, though.
      ActiveRecord::Base.timestamped_migrations = false
      manifest.class_collisions options[:group_class], options[:permission_class]
      manifest.template "app/models/group.rb.erb", "app/models/#{template_data[:group_field]}.rb", :assigns => template_data
      manifest.template "app/models/permission.rb.erb", "app/models/#{template_data[:permission_field]}.rb", :assigns => template_data
      manifest.template "config/initializers/logical_authz.rb.erb", "config/initializers/logical_authz.rb", :assigns => template_data
      manifest.template "db/seeds_logical_authz.rb.erb", "db/seeds_logical_authz.rb", :assigns => template_data
      manifest.migration_template "migrations/create_groups.rb.erb", "db/migrate", :migration_file_name => "create_#{template_data[:group_table]}", :assigns => template_data
      manifest.migration_template "migrations/create_permissions.rb.erb", "db/migrate", :migration_file_name => "create_#{template_data[:permission_table]}", :assigns => template_data
      manifest.migration_template "migrations/create_users_groups.rb.erb", "db/migrate", :migration_file_name => "create_#{template_data[:user_table]}_#{template_data[:group_table]}", :assigns => template_data
      manifest.readme "README"
    end
  end
end
