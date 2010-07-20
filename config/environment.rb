# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'open-uri'

APP_CONFIG = {
  :tags_enabled => false, 
  :enable_facebook_connect => true,
  :mapp_only_alpha => false
}

Rails::Initializer.run do |config|
  # Freeze these gems into the rails app by using "rake gems:unpack"
  config.gem 'warden', :version => '0.9.5'
  config.gem 'devise', :version => '1.0.3'
  config.gem 'devise_facebook_connectable'
  config.gem 'ri_cal'
  config.gem 'geokit'

  config.time_zone = 'Pacific Time (US & Canada)'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :en
end

Time::DATE_FORMATS[:json] ="%a %b %d  %I:%M%p"

ActionController::Base.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache"
