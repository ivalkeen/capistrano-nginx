module Capistrano
  module Nginx
    module Generators
      class ConfigGenerator < Rails::Generators::Base
        desc "Create local nginx configuration file for customization"
        source_root File.expand_path('../templates', __FILE__)

        def copy_template
          copy_file "_nginx_conf.erb", "config/deploy/nginx_conf.erb"
        end
      end
    end
  end
end
