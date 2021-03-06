# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tooling/version'

Gem::Specification.new do |spec|
  spec.name          = "tooling"
  spec.version       = Tooling::VERSION
  spec.authors       = ["David Wu"]
  spec.email         = ["davidcnwu@gmail.com"]
  spec.summary       = %q{Ruby Wrapper for Salesforce's Tooling API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Dev Dependencies
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"

end
