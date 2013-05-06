Capistrano::Configuration.instance.load do
  namespace :nginx do
    desc "Setup application in nginx"
    task "setup", :role => :web do
      config_file = "config/deploy/nginx_conf.erb"
      tmp_config_file_path = "/tmp/#{application}.nginx.conf"
      unless File.exists?(config_file)
        config_file = File.join(File.dirname(__FILE__), "../../generators/capistrano/nginx/templates/_nginx_conf.erb")
      end
      File.write(tmp_config_file_path, ERB.new(File.read(config_file)).result(binding))
      upload tmp_config_file_path, "/tmp/#{application}", :via => :scp
      File.delete(tmp_config_file_path)

      run "#{sudo} mv /tmp/#{application} /etc/nginx/sites-available/#{application}"
      run "#{sudo} ln -fs /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
    end

    desc "Reload nginx configuration"
    task :reload, :role => :web do
      run "#{sudo} /etc/init.d/nginx reload"
    end
  end
end
