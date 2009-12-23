# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_convection_session',
  :secret      => '960a09fb1c29e856aace8b39539eb96c917448b3af2e3a44cdb6678e5a125affac191d4064f61bfb629790476fb0cbea88ca2239fa4ba65793d15abb7bf7d03c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
