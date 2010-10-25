module AppConfig
  class Railtie < Rails::Railtie
    initializer :load_app_config, :before => :load_application_initializers do |app|
      ::AppConfig.reload!
    end
    
    config.to_prepare { ::AppConfig.reload! }
  end
end