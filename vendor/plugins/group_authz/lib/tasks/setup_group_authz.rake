namespace :group_authz do
  task :copy_migrations do 
    source_migrations = FileList[ File::dirname(__FILE__) + "../../db/migrate/*" ]
    migration_dir = File::join(RAILS_ROOT, "db", "migrate")
    migration_prefix = Time.now.strftime("%Y%m%d%H%M%S")

    source_migrations.each do |path|
      next unless Dir.glob(File::join(migration_dir, "*_" + File::basename(path))).empty?
      FileUtils::cp(path, File::join(migration_dir, [migration_prefix, File::basename(path)].join("_"))) 
    end
  end

  task :append_seeds do
    File::open(File::join(RAILS_ROOT, "db", "seeds.rb"), "rw+") do |seeds_file|
      if seeds_file.grep(/module PermissionSeeds/)
        warn "seeds.rb appears to already have been appended by group_authz."
      end 
      
      File::open(File::join(File::dirname(__FILE__), "..", "..", "db", "seeds.sb"), "r") do |src|
        seeds_file.write(src.read)
      end
    end
  end

  desc "Setup group_authz in your application"
  task :setup => [:copy_migrations, :append_seeds]
end
