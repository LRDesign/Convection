PASSWORD = "foobar"

User.create!(
  :login => "admin",
  :email => "admin@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "Administrator"
)
