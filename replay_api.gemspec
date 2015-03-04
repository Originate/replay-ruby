# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'replay_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'replay_api'
  spec.version       = ReplayApi::VERSION
  spec.authors       = ['Originate']
  spec.email         = ['support@replay.io']
  spec.summary       = %q{Ruby SDK for Replay.io API}
  spec.description   = %q{Ruby SDK for Replay.io API}
  spec.homepage      = 'https://github.com/Originate/replay-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'typhoeus', '~> 0.6'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  spec.add_dependency 'virtus', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
