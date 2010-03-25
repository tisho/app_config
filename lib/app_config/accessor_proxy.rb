require 'active_support'
require 'active_support/core_ext/hash'

module AppConfig
  # Support nested hash accessors, so you could do AppConfig.stylesheet_expansions.standard
  class AccessorProxy < HashWithIndifferentAccess
    def method_missing(method, *args, &block)
      if self[method]
        return AccessorProxy.new(self[method]) if self[method].is_a?(Hash)
        self[method]
      else
        begin
          super
        rescue NoMethodError => e
          # return default "value if nil" if one is provided
          if args.size == 1
            args.first
          else
            raise e
          end
        end
      end
    end
    
    def convert_value(value)
      case value
      when Hash
        AccessorProxy.new(value.with_indifferent_access)
      when Array
        value.collect { |e| e.is_a?(Hash) ? AccessorProxy.new(e.with_indifferent_access) : e }
      else
        value
      end
    end    
  end
end