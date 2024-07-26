# frozen_string_literal: true

require_relative "lib/null_association/version"

Gem::Specification.new do |spec|
  spec.name        = 'null_association'
  spec.version     = NullAssociation::VERSION
  spec.authors     = ['Zeke Gabrielse']
  spec.email       = ['oss@keygen.sh']
  spec.summary     = 'Use the null object pattern with Active Record associations.'
  spec.description = 'Decorate nil Active Record associations with a null object in Rails.'
  spec.homepage    = 'https://github.com/keygen-sh/null_association'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.1'
  spec.files                 = %w[LICENSE CHANGELOG.md CONTRIBUTING.md SECURITY.md README.md] + Dir.glob('lib/**/*')
  spec.require_paths         = ['lib']

  spec.add_dependency 'rails', '>= 6.0'

  spec.add_development_dependency 'rspec-rails'
end
