# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scan_left/version"

Gem::Specification.new do |spec|
  spec.name        = "scan_left"
  spec.version     = ScanLeft::VERSION
  spec.authors     = ["Marc Siegel", "Parker Finch"]
  spec.email       = ["marc@usainnov.com", "msiegel@panoramaed.com",
                      "pfinch@panoramaed.com"]

  spec.summary     = "A tiny Ruby gem to provide the 'scan_left' operation on "\
                     "any Ruby Enumerable."
  spec.description = spec.summary
  spec.homepage    = "https://github.com/panorama-ed/scan_left"
  spec.license     = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/" # allow pushes
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] =
      "https://github.com/panorama-ed/scan_left/blob/main/CHANGELOG.md"
    spec.metadata["documentation_uri"] = "https://rubydoc.info/gems/scan_left"
  else
    raise "RubyGems 2.0 or newer is required to protect against "\
          "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.
      split("\x0").
      reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["rubygems_mfa_required"] = "true"
end
