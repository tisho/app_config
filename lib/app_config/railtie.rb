module AppConfig
  class Railtie < Rails::Railtie
    railtie_name :app_config
    
    initializer :load_app_config, :before => :load_application_initializers do |app|
    end
    
    config.to_prepare { ::AppConfig.reload! }
  end
end