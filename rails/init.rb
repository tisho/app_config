# I know using rails/init.rb is deprecated, but it seems to be the only way to 
# get Rails 2.x to actually treat the gem as a plugin and not a lazy-loadable library.
# The checks are there just in case Rails 3 ever decides to pick it up.

require 'app_config'
if defined?(Rails) && Rails::VERSION::MAJOR == 2
  ::AppConfig.reload!
  ::ActionController::Dispatcher.to_prepare { ::AppConfig.reload! }
end