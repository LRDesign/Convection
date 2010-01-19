require 'group'

Factory.define :user , :class => User do |u|
  u.name "Quentin Johnson"
  u.sequence(:login) {|n| "quentin_#{n}" }
  u.password "foobar"
  u.password_confirmation "foobar"
  u.sequence(:email) {|n| "person#{n}@example.com" }  
end

Factory.define :admin, :parent => :user do |u|
#  u.groups << Group.admin_group
end
          
