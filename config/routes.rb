ActionController::Routing::Routes.draw do |map|
  map.resources :users
                                
 map.home '/', :controller => 'home', :action => 'index'             
end
