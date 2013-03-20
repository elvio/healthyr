# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "healthyr"
  spec.version       = "0.5"
  spec.authors       = ["elvio"]
  spec.email         = ["elvio@elviovicosa.com"]
  spec.description   = %q{Healthyr is a simple Ruby on Rails app performance monitor. It takes advantage of ActiveSupport::Notifications instruments to help you find slow portions of your app.}
  spec.summary       = %q{Healthyr is a simple Ruby on Rails app performance monitor.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
