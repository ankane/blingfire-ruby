require_relative "lib/blingfire/version"

Gem::Specification.new do |spec|
  spec.name          = "blingfire"
  spec.version       = BlingFire::VERSION
  spec.summary       = "High speed text tokenization for Ruby"
  spec.homepage      = "https://github.com/ankane/blingfire-ruby"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3"

  spec.add_dependency "fiddle"
end
