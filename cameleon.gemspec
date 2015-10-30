# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name = "cameleon"
  spec.version = File.read(File.join(File.dirname(__FILE__), 'VERSION')).chomp

  spec.authors = ["daixque"]
  spec.description = %q{Cameleon is HTTP mock server framework based on Rack. You can easily create HTTP server for mockup or stub of external system for your application.}
  spec.summary = %q{Cameleon is HTTP mock server framework.}
  spec.email = ["daixque@gmail.com"]
  spec.homepage = "http://github.com/daixque/cameleon"
  spec.licenses = ["MIT"]

  spec.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "erubis", [">= 2.7.0"]
  spec.add_runtime_dependency "rack", [">= 1.6.4"]
  spec.add_runtime_dependency "hashie", [">= 3.4.3"]
  spec.add_runtime_dependency "json", [">= 1.8.3"]
  spec.add_runtime_dependency "json-schema", [">= 2.5.1"]
  spec.add_runtime_dependency "nokogiri", [">= 1.6.6"]
  spec.add_runtime_dependency "activesupport", [">= 4.0.0"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "shoulda", [">= 3.5.0"]
end

