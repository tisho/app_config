require 'app_config/version'
require 'app_config/accessor_proxy'
require 'app_config/base'
require 'app_config/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3