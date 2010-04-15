ActionController::Routing::Routes.draw do |map|
  map.resources :venues

  map.resources :events

  map.resources :venues

  map.devise_for :users

  map.resources :home, :only => :index

  map.root :controller => :home
end
