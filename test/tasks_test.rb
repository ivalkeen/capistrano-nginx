require 'test_helper'

require 'capistrano'

class TasksTest < Test::Unit::TestCase
  def setup
    @config = Capistrano::Configuration.new
    Capistrano::Configuration.instance = @config
    task = @config.find_task("nginx:setup")
    load 'capistrano/nginx/tasks.rb'
  end

  def test_add_setup_task
    namespace = @config.namespaces[:nginx]
    assert_not_nil namespace
    setup_task = namespace.tasks[:setup]
    assert_not_nil setup_task
  end

  def test_add_reload_task
    namespace = @config.namespaces[:nginx]
    assert_not_nil namespace
    setup_task = namespace.tasks[:reload]
    assert_not_nil setup_task
  end
end
