namespace :nginx do
  desc <<-DESC
        Setup nginx configuration

        Configurable options are:

          set :nginx_roles, :all
          set :nginx_path, "/etc/nginx"
          set :nginx_upstream, -> { fetch(:application) }
          set :nginx_server_name, -> { fetch(:application) }
          set :nginx_template, "config/deploy/nginx_conf.erb"
    DESC
  task :setup do
    invoke :'nginx:create_config'
    invoke :'nginx:enable_site'
  end

  task :create_config do
    on roles fetch(:nginx_roles) do
      config_file = fetch(:nginx_template)
      unless File.exists?(config_file)
        config_file = File.join(File.dirname(__FILE__), "../../generators/capistrano/nginx/templates/_nginx_conf.erb")
      end
      config = ERB.new(File.new(config_file).read, 0, '-').result(binding)
      upload! StringIO.new(config), "#{fetch(:nginx_path)}/sites-available/#{fetch(:application)}.conf"
    end
  end

  [:stop, :start, :restart, :reload, :'force-reload'].each do |action|
    desc "#{action.to_s.capitalize} nginx"
    task action do
      on roles fetch(:nginx_roles) do
        sudo :service, "nginx", action.to_s
      end
    end
  end

  desc 'Enable nginx site'
  task :enable_site do
    on roles fetch(:nginx_roles) do
      execute :ln, "-sf",
        "#{fetch(:nginx_path)}/sites-available/#{fetch(:application)}.conf",
        "#{fetch(:nginx_path)}/sites-enabled/#{fetch(:application)}.conf"
    end
    invoke :'nginx:reload'
  end

  desc 'Disable nginx site'
  task :disable_site do
    on roles fetch(:nginx_roles) do
      config_link = "#{fetch(:nginx_path)}/sites-enabled/#{fetch(:application)}.conf"
      execute :unlink, config_link if test "[ -f #{config_link} ]"
    end
    invoke :'nginx:reload'
  end
end

namespace :load do
  task :defaults do
    set :nginx_roles, :all
    set :nginx_path, "/etc/nginx"
    set :nginx_upstream, -> { fetch(:application) }
    set :nginx_server_name, -> { fetch(:application) }
    set :nginx_template, "config/deploy/nginx_conf.erb"
  end
end
