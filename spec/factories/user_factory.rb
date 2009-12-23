Factory.define :user , :class => User do |u|
  u.name "Quentin Johnson"
  u.login "quentin"
  u.password "foobar"
  u.password_confirmation "foobar"
  u.email "quentin@example.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
end
          