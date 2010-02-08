desc "Rebuild the database from scratch, useful when editing migrations"
task :full_recycle => [
  "db:install",
  "db:test:prepare"
]

desc "Build and seed the database for a new install"
task :install => [
  :environment,
  "db:migrate:reset",
  "db:seed" 
  ]