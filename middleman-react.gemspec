# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/middleman-react/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = Middleman::React::PACKAGE
  gem.version       = Middleman::React::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Justin Morris']
  gem.email         = ['desk@pixelbloom.com']
  gem.homepage      = 'https://github.com/plasticine/middleman-react'
  gem.summary       = 'Ruby gem for automatically transforming JSX and using React in Middleman.'
  gem.description   = 'Ruby gem for automatically transforming JSX and using React in Middleman.'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'middleman-core', ['>= 3.0']
  gem.add_dependency 'execjs'
  gem.add_dependency 'react-source', '~> 0.13.3'

  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'cane'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'middleman', '~> 3.2'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
end
