ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','..','..','..','config','environment'))
require 'spec/rails' 
                              
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

plugin_spec_dir = File.dirname(__FILE__)
$: << File::join(plugin_spec_dir, "spec_helper", "models")
Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
#  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = true
  config.fixture_path = File::join(File.dirname(__FILE__), 'fixtures')
  config.global_fixtures = [
    :az_accounts, :groups, :permissions
  ]
end
               
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))
ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(plugin_spec_dir, "db", "schema.rb"))

require File::join(plugin_spec_dir, "mock_auth")

Group::account_column = :az_accounts
