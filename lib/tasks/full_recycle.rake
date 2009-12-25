desc "Rebuild the database from scratch, useful when editing migrations"
task :full_recycle => [
  :environment,
  "db:migrate:reset",
  "db:seed",
  "db:test:prepare"
]
