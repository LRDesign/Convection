ActionController::Routing::Routes.draw do |map|
  map.resources :documents

  map.download_document "/documents/:id/download/:style", :controller => "documents", :action => "download", :style => "original"
  map.uploads "/uploads", :controller => "uploads", :action => "index"

  # regular user controller cannot list, create or destroy users
  map.resources :users, :except => [ :index, :show, :new, :create, :destroy ], :requirements => { :id => /[0-9]+/ }  
  map.resources :user_sessions        
  map.resources :password_resets                                                                                     
  
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
  map.root :controller => 'home', :action => 'index'    
end
