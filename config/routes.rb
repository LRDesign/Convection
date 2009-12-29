ActionController::Routing::Routes.draw do |map|
  map.resources :documents

  map.resources :users   
  map.resources :user_sessions        

  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.login '/login', :controller => "user_sessions", :action => "new"
  
  map.namespace :admin do |admin|
    admin.resources :users
  end
  
  map.home '/', :controller => 'home', :action => 'index'             
end
