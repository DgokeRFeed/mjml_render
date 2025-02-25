# frozen_string_literal: true

require_relative 'lib/mjml_render/version'

Gem::Specification.new do |spec|
  spec.name = 'mjml_render'
  spec.version = MjmlRender::VERSION
  spec.authors = ['Vladimir Popov']
  spec.email = ['vladimir.popov@debifi.com']

  spec.summary = 'Rendering mail HTML views from MJML templates for Rails'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.1'

  spec.files = Dir['lib/**/*.rb', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency('rake', '~> 13.0')
  spec.add_dependency('rspec', '~> 3.0')
  spec.add_dependency('rubocop', '~> 1.21')
  spec.add_dependency('zeitwerk', '~> 2.6')
end
