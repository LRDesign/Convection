
require 'rubygems'                                               
Dir["#{RAILS_ROOT}/vendor/gems/**"].each do |dir|    
  $: << (File.directory?(lib = "#{dir}/lib") ? lib : dir)
end

if (Gem.available?('metric_fu') and Gem.available?('rspec'))
                 

  require 'erb'
  require 'spec/rake/spectask' 
  require 'metric_fu'
  
  MetricFu::Configuration.run do |config|
      #define which metrics you want to use
      config.metrics  = [:churn, :saikuro, :stats, :flog, :flay, :reek, :roodi, :rcov]
      config.graphs = []
      #config.graphs   = [:flog, :flay, :reek, :roodi, :rcov]
      config.flay     = { :dirs_to_flay => ['app', 'lib']  } 
      config.flog     = { :dirs_to_flog => ['app', 'lib']  }
      config.reek     = { :dirs_to_reek => ['app', 'lib']  }
      config.roodi    = { :dirs_to_roodi => ['app', 'lib'] }
      config.saikuro  = { :output_directory => 'scratch_directory/saikuro', 
                          :input_directory => ['app', 'lib'],
                          :cyclo => "",
                          :filter_cyclo => "0",
                          :warn_cyclo => "5",
                          :error_cyclo => "7",
                          :formater => "text"} #this needs to be set to "text"
      config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10}
      config.rcov     = { :test_files => ['test/**/*_test.rb', 
                                          'spec/**/*_spec.rb'],
                          :rcov_opts => ["--sort coverage", 
                                         "--no-html", 
                                         "--text-coverage",
                                         "--no-color",
                                         "--profile",
                                         "--rails",
                                         "--exclude /gems/,/Library/,spec"]}                                                
  end
                          
                                       
  namespace :ci do
    desc "Set up for testing in continuous integration"
    task :setup, [ :db_host, :db_user, :db_pass, :db_name ] => [ "config/database.yml", 
        :environment, "db:migrate:reset", "db:seed", "db:test:prepare" ] do |task, args|
    end          
             
  
    desc "Run tests for CI"
    task :run, [ :db_host, :db_user, :db_pass, :db_name ] => [ :spec, 'metrics:all' ] do
      out = ENV['CC_BUILD_ARTIFACTS']  
      mv 'coverage/', "#{out}/coverage" if out
    end
  
    Spec::Rake::SpecTask.new do |t, args|              
      t.spec_opts = [ "--colour", "--format", "html:#{ENV['CC_BUILD_ARTIFACTS']}/spec_output.html", 
        "--loadby", "mtime", "--reverse"]
      t.spec_opts += ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['spec/**/*_spec.rb']
      t.rcov = true
      t.rcov_opts = lambda do
        IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
      end    
      t.rcov_opts += [ "--output", "#{ENV['CC_BUILD_ARTIFACTS']}/coverage"]     
    end                            
    task :spec => [ :setup, :show_context ] 
  
    task :show_context do 
      puts
      puts "[CruiseControl] Build environment:"
      puts "[CruiseControl] #{`cat /etc/issue`}"
      puts "[CruiseControl] #{`uname -a`}"
      puts "[CruiseControl] #{`ruby -v`}"
      `gem env`.each_line {|line| print "[CruiseControl] #{line}"}
      puts "[CruiseControl] Local gems:"
      `gem list`.each_line {|line| print "[CruiseControl] #{line}"}
      puts     
      puts ENV['CC_BUILD_ARTIFACTS']   
    end
  
  
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

end
