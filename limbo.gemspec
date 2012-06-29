# -*- encoding: utf-8 -*-
require File.expand_path('../lib/limbo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anders Carlsson and Anders Törnqvist"]
  gem.email         = ["dev+ankor+unders@elabs.se"]
  gem.description   = %q{Limbo exception client.}
  gem.summary       = %q{Limbo client post exception to the Limbo exception service.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "limbo"
  gem.require_paths = ["lib"]
  gem.version       = Limbo::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "fakeweb"
  gem.add_development_dependency "rails"
end
