# frozen_string_literal: true

require_relative "lib/jekyll_waxify/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-waxify"
  spec.version       = Jekyll::Waxify::VERSION
  spec.authors       = ["Peter Binkley"]
  spec.email         = ["peter.binkley@ualberta.ca"]

  spec.summary       = "A Jekyll plugin that installs basic minicomp/wax components "
  spec.description   = "A Jekyll plugin that installs basic minicomp/wax components , only longer"
  spec.homepage      = "https://github.com/pbinkley/jekyll-waxify"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pbinkley/jekyll-waxify"
  spec.metadata["changelog_uri"] = "https://github.com/pbinkley/jekyll-waxify"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "byebug", ">= 11"
  spec.add_dependency "deep_merge", "~> 1.2"
  spec.add_runtime_dependency 'progress_bar', '~> 1.3'
  spec.add_runtime_dependency 'rainbow', '~> 3.0'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'safe_yaml', '~> 1.0'
  spec.add_runtime_dependency 'github-pages', '~> 213'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
