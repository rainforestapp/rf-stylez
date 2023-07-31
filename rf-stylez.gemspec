# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rf/stylez/version"

Gem::Specification.new do |spec|
  spec.name          = "rf-stylez"
  spec.version       = Rf::Stylez::VERSION
  spec.authors       = ["Emanuel Evans"]
  spec.email         = ["emanuel@rainforestqa.com"]
  spec.license       = "MIT"

  spec.summary       = %q{Styles for Rainforest code}
  spec.description   = "Configurations for Rubocop and other style enforcers/linters"
  spec.homepage      = "https://github.com/rainforestapp/rf-stylez"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["rf-stylez"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rubocop", "1.54.2"
  spec.add_runtime_dependency "rubocop-rails", "2.20.2"
  spec.add_runtime_dependency "rubocop-rspec", "2.23.0"
  spec.add_runtime_dependency "reek", "~> 6.1"
  spec.add_runtime_dependency "get_env", "~> 0.2.0"
  spec.add_runtime_dependency "unparser", "~> 0.6"
  spec.add_runtime_dependency "pronto", "~> 0.11.1"
  spec.add_runtime_dependency "pronto-rubocop", "~> 0.11.5"

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", ">= 3.4"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec_junit_formatter"
end
