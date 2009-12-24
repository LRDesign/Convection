ActionController::Routing::Routes.draw do |map|
  map.resources :users   
  map.resources :user_sessions        

  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.login '/login', :controller => "user_sessions", :action => "new"
  
  map.home '/', :controller => 'home', :action => 'index'             
end
