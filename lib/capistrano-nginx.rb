require "capistrano-nginx/version"

module Capistrano
  module Nginx
    unless Capistrano::Configuration.respond_to?(:instance)
      abort "This extension requires Capistrano 2"
    end

    Capistrano::Configuration.instance.load do
      namespace :nginx do
        desc "Setup application in nginx"
        task "setup" do

        end
      end
    end
  end
end
