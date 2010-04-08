namespace :group_authz do
  task :copy_migrations do 
    source_migrations = FileList[ File.join(File::dirname(__FILE__), "..", "..", "db", "migrate") + "/*" ]
    migration_dir = File::join(RAILS_ROOT, "db", "migrate")
    migration_prefix = Time.now.strftime("%Y%m%d%H%M%S")

    source_migrations.each do |path|
      existing_migrations = Dir.glob(File::join(migration_dir, "*_" + File::basename(path)))
      next unless existing_migrations.empty?
      puts "Copying #{File::basename(path)} into #{migration_dir}"
      FileUtils::cp(path, File::join(migration_dir, [migration_prefix, File::basename(path)].join("_"))) 
      migration_prefix = migration_prefix.next
    end
  end

  task :append_seeds do
    File::open(File::join(RAILS_ROOT, "db", "seeds.rb"), "a+") do |seeds_file|
      seeds_file.rewind
      if seeds_file.grep(/.*module PermissionSeeds.*/).empty?
        puts "Appending group_authz seeds to db/seeds.rb"
        seeds_file.seek(-1, IO::SEEK_END)

        File::open(File::join(File::dirname(__FILE__), 
                              "..", "..", "db", "seeds.rb"), "r") do |src|
          seeds_file.write(src.read)
        end
      end 
    end
  end

  desc "Setup group_authz in your application"
  task :setup => [:copy_migrations, :append_seeds]
end
