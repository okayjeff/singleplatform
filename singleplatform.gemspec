# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'singleplatform/version'

Gem::Specification.new do |spec|
  spec.name          = "singleplatform"
  spec.version       = Singleplatform::VERSION
  spec.authors       = ["Jeff Gharakhanian"]
  spec.email         = ["jg@okayjeff.com"]

  spec.summary       = "A Ruby client library for accessing the SinglePlatform API."
  spec.homepage      = "http://github.com/okayjeff/singleplatform"
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "httparty"
end
