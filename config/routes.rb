ActionController::Routing::Routes.draw do |map|
  map.mapp 'mapp/:group', :controller => 'mapp', :action => 'index', :group => 'schedule'
  map.mapp 'mapp.:format/:group', :controller => 'mapp', :action => 'index', :group => 'schedule'

  #unless APP_CONFIG[:mapp_only_alpha] 
    map.resources :taggings
    map.resources :events, :has_many => :taggings
    map.resources :venues, :has_many => :events
    map.devise_for :users
    map.root :controller => :events
  #end 

end
