class LogicalAuthzModelsGenerator < Rails::Generator::Base
  def manifest 
    record do |manifest|
      manifest.class_collisions "Group", "Permission"
      manifest.file "app/models/group.rb", "app/models/group.rb", :collision => :skip
      manifest.file "app/models/permission.rb", "app/models/permission.rb", :collision => :skip
      manifest.migration_template "setup_logical_authz.rb", "db/migrate", :migration_file_name => "setup_logical_authz"
    end
  end
end
