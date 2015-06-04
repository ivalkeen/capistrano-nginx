# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capistrano/nginx/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ivan Tkalin"]
  gem.email         = ["itkalin@gmail.com"]
  gem.description   = "Simple nginx management with capistrano"
  gem.summary       = "Configuration and managements capistrano tasks for nginx"
  gem.homepage      = "https://github.com/ivalkeen/capistrano-nginx"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "capistrano-nginx"
  gem.require_paths = ["lib"]
  gem.version       = Capistrano::Nginx::VERSION

  gem.add_dependency 'capistrano', '~> 2.0'
end
