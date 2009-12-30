PASSWORD = "foobar"

# TODO create default groups

User.create!(
  :login => "admin",
  :email => "admin@example.com",
  :password => PASSWORD, 
  :password_confirmation => PASSWORD,
  :name => "Administrator",
  :admin => true  # TODO replace this with admin group membership
)
