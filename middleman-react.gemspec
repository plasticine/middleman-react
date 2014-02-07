# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path('../lib/middleman-react/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = Middleman::React::PACKAGE
  gem.version       = Middleman::React::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Justin Morris"]
  gem.email         = ["desk@pixelbloom.com"]
  gem.homepage      = "https://github.com/plasticine/middleman-react"
  gem.summary       = %q{Ruby gem for automatically transforming JSX and using React in Middleman.}
  gem.description   = %q{Ruby gem for automatically transforming JSX and using React in Middleman.}
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "middleman-core", [">= 3.0"]
  gem.add_dependency "execjs"
  gem.add_dependency "react-source", "0.8.0"

  gem.add_development_dependency "appraisal"
  gem.add_development_dependency "aruba"
  gem.add_development_dependency "cane"
  gem.add_development_dependency "coveralls"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rubocop"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "pry"
end
