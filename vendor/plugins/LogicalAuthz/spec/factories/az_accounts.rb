require 'group'

Factory.define :az_account , :class => AzAccount do |u|
  u.name "Quentin Johnson"
end

Factory.define :admins, :class => Group do |g|
  g.name "Administration"
end

Factory.define :group do |g| 
  g.sequence(:name) {|n| "group_#{n}"}
end

Factory.define :az_admin, :parent => :az_account do |u|
  u.groups {|u| [ u.association(:admins) ]}
end
          
