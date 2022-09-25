# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'nubank-client'
  spec.version       = '0.0.1'
  spec.authors       = ['']
  spec.email         = ['']
  spec.platform = Gem::Platform::RUBY

  spec.summary = 'This gem is a nubank API client :)'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.4')
  spec.executables << 'nubank_client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|exe)/}) }
  end

  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
