# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rekkyo/version"

Gem::Specification.new do |spec|
  spec.name          = "rekkyo"
  spec.version       = Rekkyo::VERSION
  spec.authors       = ["Yuji Hanamura"]
  spec.email         = ["yuji.developer@gmail.com"]

  spec.summary       = "An enumerated type in Ruby."
  spec.description   = "Rekkyo is a gem for defining an enumerated type in Ruby."
  spec.homepage      = "https://github.com/yujideveloper/rekkyo"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/yujideveloper/rekkyo/tree/main/CHANGELOG.md"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0"

  spec.add_development_dependency "appraisal", ">= 2.4.1"
  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "pry", ">= 0.12.2"
  spec.add_development_dependency "pry-doc", ">= 0.13.5"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rubocop", ">= 1.25.0"
end
