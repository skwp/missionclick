ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.resources :home, :only => :index
  map.resources :venues
  map.resources :events
  map.resources :venues

  map.root :controller => :home
end
