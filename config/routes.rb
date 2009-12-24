ActionController::Routing::Routes.draw do |map|
  map.resources :users   
  map.resource       :user_session        

  map.home '/', :controller => 'home', :action => 'index'             
end
