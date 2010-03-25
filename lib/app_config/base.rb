require 'yaml'
require 'erb'

module AppConfig
  CONFIG_PATH = defined?(Rails) ? Rails.root.join('config') : Pathname.new(File.dirname(__FILE__))
  DEFAULT_CONFIG_PATH = CONFIG_PATH.join('appconfig.defaults.yml')
  
  class << self
    def reload!
    	@@config = AccessorProxy.new(load_config_file(DEFAULT_CONFIG_PATH))

      config_files.each do |config_file|
    	  @@config.merge!(load_config_file(config_file))
      end
    end
    
    def [](key)
      return @@config[key]
    end
    
    def config_files
      Dir[CONFIG_PATH.join('*appconfig.yml')]
    end
    
    def get(key)
      return AppConfig[key]
    end
    
    def load_config_file(file_path)
      YAML::load(ERB.new((IO.read(file_path))).result).symbolize_keys
    rescue Errno::ENOENT
      {}
    end
    
    def method_missing(method, *args, &block)
      @@config.send method, *args, &block
    end
  end
  
  reload!
end