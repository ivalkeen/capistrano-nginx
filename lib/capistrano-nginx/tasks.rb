Capistrano::Configuration.instance.load do
  namespace :nginx do
    desc "Setup application in nginx"
    task "setup" do
      config_file = "config/nginx_conf.erb"
      unless File.exists?(config_file)
        config_file = "generators/capistrano-nginx/templates/_nginx_conf.erb"
      end
      config = ERB.new(File.read(config_file)).result(binding)
      set :user, sudo_user
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
