ActionController::Routing::Routes.draw do |map|
  map.resources :events
  map.resources :venues, :has_many => :events

  map.devise_for :users

  map.root :controller => :events
end
