require "capistrano-nginx/version"

module Capistrano
  module Nginx
  end
end

unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance.load do
  namespace :nginx do
    desc "Setup application in nginx"
    task "setup" do
      config = ERB.new(File.read(File.join(File.dirname(__FILE__), "deploy/nginx.erb"))).result(binding)
      set :user, "ivan"
      put config, "/tmp/#{application}"
      run "#{sudo} mv /tmp/#{application} /etc/nginx/sites-available/#{application}"
      run "#{sudo} ln -fs /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
    end

    desc "Reload nginx configuration"
    task :reload do
      set :user, sudo_user
      run "#{sudo} /etc/init.d/nginx reload"
    end
  end
end
