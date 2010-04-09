namespace :logical_authz do
  task :append_seeds do
    File::open(File::join(RAILS_ROOT, "db", "seeds.rb"), "a+") do |seeds_file|
      seeds_file.rewind
      if seeds_file.grep(/.*module PermissionSeeds.*/).empty?
        puts "Appending logical_authz seeds to db/seeds.rb"
        seeds_file.seek(-1, IO::SEEK_END)

        File::open(File::join(File::dirname(__FILE__), 
                              "..", "..", "db", "seeds.rb"), "r") do |src|
          seeds_file.write(src.read)
        end
      end 
    end
  end

  desc "Setup logical_authz in your application"
  task :setup => [:append_seeds]
end
