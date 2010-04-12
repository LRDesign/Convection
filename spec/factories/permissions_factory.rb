require 'group'

Factory.define :some_guys, :class => Group do |g|
  g.name "Some Guys"
end

Factory.define(:base_permission, :class => Permission) do |prm|
  prm.controller "application"
  prm.action nil
  prm.subject_id nil  
end

Factory.define :permission, :parent => :base_permission do |prm|
  prm.group {|prm| prm.association(:some_guys)}
end