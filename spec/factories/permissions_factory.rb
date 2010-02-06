require 'group'

Factory.define :some_guys, :class => Group do |g|
  g.name "Some Guys"
end

Factory.define :permission do |prm|
  prm.group {|prm| prm.association(:some_guys)}
  prm.controller "application"
  prm.action nil
  prm.subject_id nil
end
