begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You'll need to run the tests from within a rails app with rspec support."
  exit
end
 
plugin_spec_dir = File.dirname(__FILE__)