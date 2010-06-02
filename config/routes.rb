ActionController::Routing::Routes.draw do |map|
  map.mapp_admin 'mapp/admin', :controller => 'mapp_admin_login', :action => 'login'
  map.mapp 'mapp/:group', :controller => 'mapp', :action => 'index', :group => 'schedule'
  map.mapp 'mapp.:format/:group', :controller => 'mapp', :action => 'index', :group => 'schedule'

  map.resources :invite_requests
  map.resources :taggings
  map.resources :events, :has_many => :taggings
  map.resources :venues, :has_many => :events
  map.devise_for :users
  map.root :controller => :events

end
