AppConfig
=========

	 ______                  ____                     ___                 
	/\  _  \                /\  _`\                 /'___\ __             
	\ \ \L\ \  _____   _____\ \ \/\_\   ___    ___ /\ \__//\_\     __     
	 \ \  __ \/\ '__`\/\ '__`\ \ \/_/_ / __`\/' _ `\ \ ,__\/\ \  /'_ `\   
	  \ \ \/\ \ \ \L\ \ \ \L\ \ \ \L\ \\ \L\ \\ \/\ \ \ \_/\ \ \/\ \L\ \  
	   \ \_\ \_\ \ ,__/\ \ ,__/\ \____/ \____/ \_\ \_\ \_\  \ \_\ \____ \ 
	    \/_/\/_/\ \ \/  \ \ \/  \/___/ \/___/ \/_/\/_/\/_/   \/_/\/___L\ \
	             \ \_\   \ \_\                                     /\____/
	              \/_/    \/_/                                     \_/__/

AppConfig does pretty much what [all](http://github.com/cjbottaro/app_config) [the](http://github.com/stephencelis/app) [other](http://github.com/merbjedi/app_config) [great](http://github.com/oshuma/app_config) application configuration do, but requires even less configuration. It reads your config from YAML files, supports nested options, and automatically reloads your changes in `development` mode. It also has a README with ASCII art in it.

Install
=======

First, install the `appconfig` gem. It's *Rails 3* ready, but it will also run fine in *Rails 2.3+*.

	gem install appconfig
	
That's it.

Usage
=======

By default AppConfig will try to read config options from `config/appconfig.defaults.yml` and `*.appconfig.yml`.

	# sample appconfig.defaults.yml
	
	admins:

	  tisho: 
	    full_name: Tisho Georgiev
	    email: tihomir.georgiev@gmail.com

	  josh:
	    full_name: Joshua Krall
	    email: josh@transfs.com

Inside your Rails app, you can access your configuration options using the `AppConfig` object.

	@admin_name = AppConfig.admins.tisho.full_name

Since *AppConfig's* storage mechanism is something like the lovechild of `HashWithIndifferentAccess` and `OpenStruct`, you can access your configuration in a bunch of different ways.

	AppConfig.admins.tisho
	AppConfig[:admins].tisho
	AppConfig[:admins][:tisho]
	AppConfig['admins']['tisho']
	AppConfig['admins'][:tisho]

You get the idea.

If you're prefer the `OpenStruct` methodized syntax for accessing configuration options, you can optionally provide a fallback value for an option that may not exist.

	AppConfig.option_that_doesnt_exist('fallback') 	#=> 'fallback'

Reloading
-------

When running your app in your `development` environment, *AppConfig* reloads on every request. It does that by using Rails's `ActionController::Dispatcher.to_prepare` hook.

If you need to reload your configuration manually, you can run:

	AppConfig.reload!

Found a bug?
=======

By all means, drop us a line. Or better yet, fork the project, fix the bug and send us a pull request. We'll thank you for it.

License
=======

Copyright (c) 2010 Josh Krall & Tisho Georgiev, released under the MIT license
