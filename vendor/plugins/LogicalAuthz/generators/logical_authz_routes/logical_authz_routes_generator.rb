ActionController::Routing::Routes.draw do |map|
  map.resources :groups
  map.group_user '/group_user', :controller => 'groups_users', :action => 'create', :conditions => { :method => :post }
  map.ungroup_user '/ungroup_user', :controller => 'groups_users', :action => 'destroy', :conditions => { :method => :delete }
  map.permit_page '/permit_page', :controller => 'permissions', :action => 'create', :conditions => { :method => :post } 
  map.forbid_page '/forbid_page', :controller => 'permissions', :action => 'destroy', :conditions => { :method => :delete }
end
