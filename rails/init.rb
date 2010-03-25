require 'app_config'

if Rails::VERSION::MAJOR < 3
  ActionController::Dispatcher.to_prepare(:app_config) { AppConfig.reload! }
else
  module AppConfig
    class Railtie < Rails::Railtie
      railtie_name :app_config
      config.to_prepare(:app_config) { AppConfig.reload! }
    end
  end
end