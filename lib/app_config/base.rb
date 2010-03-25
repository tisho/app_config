require 'yaml'
require 'erb'

module AppConfig
  mattr_accessor :config_files_path, :default_config_file_path
  
  class << self
    def reload!
      set_default_paths if config_files_path.nil?
    	@@config = AccessorProxy.new(load_config_file(default_config_file_path))

      config_files.each do |config_file|
    	  @@config.merge!(load_config_file(config_file))
      end
    end
    
    def [](key)
      return @@config[key]
    end
    
    def config_files
      Dir[config_files_path.join('*appconfig.yml').to_s]
    end
    
    def get(key)
      return AppConfig[key]
    end
    
    def load_config_file(file_path)
      YAML::load(ERB.new((IO.read(file_path))).result).symbolize_keys
    rescue Errno::ENOENT
      {}
    end
    
    def set_default_paths
      self.config_files_path = ::Rails.root.join('config')
      self.default_config_file_path = self.config_files_path.join('appconfig.defaults.yml')
    end
    
    def method_missing(method, *args, &block)
      @@config.send method, *args, &block
    end
  end
end