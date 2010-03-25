require 'spec_helper'

describe AppConfig do
  before(:all) do
    silence_warnings do
      module AppConfig
        CONFIG_PATH = Pathname.new(File.join(File.dirname(__FILE__), 'fixtures'))
        DEFAULT_CONFIG_PATH = CONFIG_PATH.join('appconfig.defaults.yml')
      end
    end
  end
  
  before(:each) do
    AppConfig.reload!
  end
  
  it 'should always load default config file first' do
    # assume there are no other config files
    AppConfig.stub!(:config_files).and_return([])
    AppConfig.reload!
    
    {
      %{AppConfig.domain} => 'unknown.com',
      %{AppConfig.admin.name} => 'John Smith',
      %{AppConfig.admin.email} => 'john.smith@unknown.com'
    }.each_pair do |property, expected_value|
      eval(property).should == expected_value
    end
  end
  
  it 'should override the default config with whatever is in *.appconfig.yml' do
    AppConfig.domain.should == 'stillunknown.com'
  end
  
  context 'when accessing first-level congig keys' do
    it 'should allow struct-like access to config keys' do
      AppConfig.search_engines.should == %w{google.com yahoo.com bing.com}
    end
    
    it 'should allow hash-like access to config keys' do
      AppConfig[:search_engines].should == %w{google.com yahoo.com bing.com}
      AppConfig['search_engines'].should == %w{google.com yahoo.com bing.com}
    end
  end
  
  context 'when accessing deeply nested config keys' do
    it 'should allow struct-like access to config keys' do
      AppConfig.admin.name.should == 'John Smith'
    end
    
    it 'should allow hash-like access to config keys' do
      AppConfig[:admin][:name].should == 'John Smith'
      AppConfig['admin']['name'].should == 'John Smith'
    end
    
    it 'should allow you to mix hash-like and struct-like syntax when accessing deeply nested config keys' do
      AppConfig[:admin].name.should == 'John Smith'
      AppConfig['admin'].name.should == 'John Smith'
      AppConfig.admin[:name].should == 'John Smith'
      AppConfig.admin['name'].should == 'John Smith'
    end
  end

  it 'should behave like a hash' do
    AppConfig.keys.should include(*%w{admin search_engines domain})
  end
  
  it 'should allow you to pass an optional "value if key not found" parameter when using struct-like syntax' do
    AppConfig.nonexistant_key('fallback').should == 'fallback'
  end
end