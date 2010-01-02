require 'erb'
require 'spec/rake/spectask'
                              
namespace :ci do
  desc "Set up for testing in continuous integration"
  task :setup, [ :db_host, :db_user, :db_pass, :db_name ] => [ "config/database.yml", 
      :environment, "db:migrate:reset", "db:seed", "db:test:prepare" ] do |task, args|
  end          


  desc "Run tests for CI"
  Spec::Rake::SpecTask.new do |t, args|
    t.spec_opts = [ "--colour", "--format html:#{ENV['CC_BUILD_ARTIFACTS']}/spec_output.html", 
      "--loadby mtime", "--reverse"]
    # t.rcov = true  
  end                            
  task :spec,  [ :db_host, :db_user, :db_pass, :db_name ] => [ :setup ] 
end

file "config/database.yml", [ :db_host, :db_user, :db_pass, :db_name ] do |task, args|
  template = ERB.new(File.open('config/database.yml.ci.erb') { |file| file.read })
  db_host = args[:db_host]
  db_user = args[:db_user]
  db_pass = args[:db_pass]
  db_name = args[:db_name]                                             
  puts template.result(binding)
  File.open(task.name, "w"){ |file| file << template.result(binding) }  
end

