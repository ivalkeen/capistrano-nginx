# Capistrano::nginx

Nginx support for Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.0.0'
gem 'capistrano-nginx', github: 'koenpunt/capistrano-nginx'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-nginx

## Usage

Require in `Capfile`:

```ruby
require 'capistrano/nginx'
```

Launch new tasks:

    $ cap production nginx:setup
    $ cap production nginx:reload

If you want to customize the nginx configuration, you can use the Rails generator to create a local copy of the config template:

    $ rails generate capistrano:nginx:config

And then edit `config/deploy/nginx_conf.erb` as you like.

Configurable options, shown here with defaults:

```ruby
set :nginx_path, '/etc/nginx' # directory containing sites-available and sites-enabled
set :nginx_template, 'config/deploy/nginx_conf.erb' # configuration template
set :nginx_server_name, 'example.com' # optional, defaults to :application
set :nginx_upstream, 'example-app' # optional, defaults to :application
set :nginx_listen, 80 # optional, default is not set
set :nginx_roles, :all
```

### Tasks

This gem provides the following Capistrano tasks:

* `nginx:setup` creates `/etc/nginx/sites-available/APPLICATION.conf` and links it to `/etc/nginx/sites-enabled/APPLICATION.conf`
* `nginx:stop` invokes `service nginx stop` on server
* `nginx:start` invokes `service nginx start` on server
* `nginx:restart` invokes `service nginx restart` on server
* `nginx:reload` invokes `service nginx reload` on server
* `nginx:force-reload` invokes `service nginx force-reload` on server
* `nginx:enable_site` creates symlink in sites-enabled directory
* `nginx:disable_site` removes symlink from sites-enabled directory

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
