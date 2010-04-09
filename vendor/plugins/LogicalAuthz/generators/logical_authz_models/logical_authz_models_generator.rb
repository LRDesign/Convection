class LogicalAuthzModelsGenerator < Rails::Generator::Base
  def add_options!(opti)
    opti.on("-u", "--user UserClass"){|val| options[:user_class] = val}
    opti.on("-p", "--permission PermissionClass"){|val| options[:permission_class] = val}
    opti.on("-g", "--group GroupClass"){|val| options[:group_class] = val}
  end

  default_options(:permission_class => "Permission", 
                  :group_class => "Group")

  def manifest 
    raise "User class name (--user) is required!" unless options[:user_class]
    template_data = {
      :user_class => options[:user_class],
      :permission_class => options[:permission_class],
      :group_class => options[:group_class],
      :user_table => options[:user_class].tableize,
      :permission_table => options[:permission_class].tableize,
      :group_table => options[:group_class].tableize
    }

    record do |manifest|
      manifest.class_collisions options[:group_class], options[:permission_class]
      manifest.template "app/models/group.rb", "app/models/group.rb", :assigns => template_data
      manifest.file "app/models/permission.rb", "app/models/permission.rb"
      manifest.migration_template "setup_logical_authz.rb", "db/migrate", :migration_file_name => "setup_logical_authz"
    end
  end
end
