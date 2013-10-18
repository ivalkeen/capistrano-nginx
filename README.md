# capistrano-nginx

This gem provides two capistrano tasks:

* `nginx:setup` - creates `/etc/nginx/sites-available/YOUR_APP` and links it to `/etc/nginx/sites-enabled/YOUR_APP`
* `nginx:setup_sites_enabled` - creates `/etc/nginx/sites-available`, `/etc/nginx/sites-enabled`  and `/etc/nginx/conf.d/sites-enabled.conf`  for nginx installation that lack those folders
* `nginx:reload` - invokes `/etc/init.d/nginx reload` on server
* `nginx:restart` - invokes `/etc/init.d/nginx restart` on server

And nginx configuration file generator, that will create local copy of default nginx config for customization.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-nginx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-nginx

## Usage

Add this to your `config/deploy.rb` file:

    require 'capistrano/nginx/tasks'

Make sure, following variables are defined in your `config/deploy.rb`:

* `application` - application name
* `server_name` - your application's server_name in nginx (e.g. `example.com`)
* `deploy_to` - deployment path
* `sudo_user` - user name with sudo privileges (needed to config/restart nginx)
* `app_port` - application port (optional)
* `nginx_conf_name` - the name of the configuration file inside `sites-available` (optional, defaults to: `application`)

Launch new tasks:

    $ cap nginx:setup
    $ cap nginx:reload

Or you can add hook to call this tasks after `deploy:setup`. Add to your `config/deploy.rb`:

    after "deploy:setup", "nginx:setup", "nginx:reload"

If you want to customize nginx configuration, just generate local nginx config before running `nginx:setup`:

    $ rails generate capistrano:nginx:config

And then edit file `config/deploy/nginx_conf.erb` as you like.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
