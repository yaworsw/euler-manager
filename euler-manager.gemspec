# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'euler/version'

Gem::Specification.new do |spec|
  spec.name          = 'euler-manager'
  spec.version       = Euler::VERSION
  spec.authors       = ['William Yaworsky']
  spec.email         = ['wj.px01@gmail.com']
  spec.summary       = %q{Manage and test project Euler problems from your command line.}
  # spec.description   = %q{This gem provides a framework for solving project Euler problems.  You can test}
  spec.homepage      = 'https://github.com/yaworsw/euler-manager'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'commander'
  spec.add_dependency 'colorize'
  spec.add_dependency 'peach'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'rspec',  '~> 2.0'
  spec.add_development_dependency 'fakefs', '~> 0.5.2'

  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'reverse_markdown'
end
