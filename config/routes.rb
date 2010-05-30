ActionController::Routing::Routes.draw do |map|
  map.resources :taggings

  map.resources :events, :has_many => :taggings
  map.resources :venues, :has_many => :events

  map.devise_for :users
  
  map.mapp 'mapp', :controller => 'mapp', :action => 'index'

  map.root :controller => :events
end
