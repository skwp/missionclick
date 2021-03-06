ActionController::Routing::Routes.draw do |map|

  map.mapp_admin 'mapp/admin', :controller => 'mapp_admin_login', :action => 'login'
  map.mapp_admin_logout 'mapp/admin/logout', :controller => 'mapp_admin_login', :action => 'logout'
  map.mapp_bulk_edit 'mapp/bulk_edit', :controller => 'mapp', :action => 'bulk_edit'
  map.mapp 'mapp/:group', :controller => 'mapp', :action => 'index', :group => 'now'
  map.mapp 'mapp.:format/:group', :controller => 'mapp', :action => 'index', :group => 'schedule'

  map.resources :invite_requests
  map.resources :festivals
  map.resources :taggings
  map.resources :events, :has_many => :taggings, :collection=> {:starred => :get}, :member => {:toggle_star => :post}
  map.resources :venues, :has_many => :events

  map.devise_for :users
  map.root :controller => :events

end
