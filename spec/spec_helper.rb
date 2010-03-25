$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'active_support'
require 'active_support/core_ext/kernel/reporting'

require 'app_config'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
end