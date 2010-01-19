ActionController::Routing::Routes.draw do |map|
  map.resources :documents

  # regular user controller cannot create or destroy users
  map.resources :users, :except => [ :index, :new, :create, :destroy ], :requirements => { :id => /[0-9]+/ }  
  
  map.resources :user_sessions        

  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.login '/login', :controller => "user_sessions", :action => "new"
  
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resource  :preferences
    admin.resources :groups
    admin.group_user '/group_user', :controller => 'groups_users', :action => 'create', :conditions => { :method => :post }
    admin.ungroup_user '/ungroup_user', :controller => 'groups_users', :action => 'destroy', :conditions => { :method => :delete }
  end
  
  map.home '/', :controller => 'home', :action => 'index'             
end
