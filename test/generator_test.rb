require 'test_helper'
require 'rails/generators/test_case'
require 'generators/capistrano/nginx/config_generator'

class GeneratorTest < Rails::Generators::TestCase
  tests Capistrano::Nginx::Generators::ConfigGenerator
  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination
  teardown { rm_rf(destination_root) }

  def test_generates_local_config_file
    run_generator
    assert_file 'config/deploy/nginx_conf.erb'
  end
end
