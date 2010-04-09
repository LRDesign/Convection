module LogicalAuthz
  class ModelsGenerator < Rails::Generator::Base
    record do |manifest|
      manifest.class_collisions "Group", "Permission"
      manifest.file "app/models/group.rb", "app/models/group.rb", :collision => :skip
      manifest.file "app/models/permission.rb", "app/models/permission.rb", :collision => :skip
      manifest.migration_file "setup_logical_authz.rb", "db/migrate"
    end
  end
end

