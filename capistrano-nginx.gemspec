# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-nginx'
  spec.version       = '1.0.0'
  spec.authors       = ['Ivan Tkalin', 'Koen Punt']
  spec.email         = ['itkalin@gmail.com', 'mail@koen.pt']
  spec.description   = %q{Simple nginx management for Capistrano 3.x}
  spec.summary       = %q{Simple nginx management for Capistrano 3.x}
  spec.homepage      = 'https://github.com/ivalkeen/capistrano-nginx'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
