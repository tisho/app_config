require 'rubygems'
require 'rake'
require File.dirname(__FILE__) + "/lib/app_config/version.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "appconfig"
    gem.version = AppConfig::VERSION::STRING
    gem.summary = %Q{Provides an OpenStruct/Hash-like syntax for accessing your app's configuration options, loaded from a YAML file.}
    gem.description = %Q{Provides an OpenStruct/Hash-like syntax for accessing your app's configuration options, loaded from a YAML file. Supports multiple configuration files, nested configuration groups and fallback options.}
    gem.email = "tihomir.georgiev@gmail.com"
    gem.homepage = "http://github.com/tisho/appconfig"
    gem.authors = ["Tisho Georgiev", "Joshua Krall"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "rails", ">= 2.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "appconfig #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
