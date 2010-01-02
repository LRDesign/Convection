# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config| 
  
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir|    
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end  
  
  # Required gems 
  config.gem "haml"
  config.gem "authlogic", :version => ">= 2.0.9"
  config.gem "rspec", :lib => false, :version => ">= 1.2.4"
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.4"
  config.gem "thoughtbot-factory_girl", :lib => "factory_girl", :version => ">= 1.2.1"
  config.gem "chronic"
 
  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
end
