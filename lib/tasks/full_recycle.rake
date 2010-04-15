namespace :db do
  #Change this to raise once full_recycle shouldn't work
  task :only_if_undeployed

  desc "Rebuild the database from scratch, useful when editing migrations"
  task :full_recycle => [
    :only_if_undeployed,
    "install",
    "test:prepare"
  ]

  desc "Build and seed the database for a new install"
  task :install => [
    :environment,
    "migrate:reset",
    "seed" 
    ]
end
