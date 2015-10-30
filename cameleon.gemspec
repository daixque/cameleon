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

  spec.add_runtime_dependency "erubis", [">= 0"]
  spec.add_runtime_dependency "rack", [">= 0"]
  spec.add_runtime_dependency "hashie", [">= 0"]
  spec.add_runtime_dependency "json", [">= 0"]
  spec.add_runtime_dependency "json-schema", [">= 0"]
  spec.add_runtime_dependency "nokogiri", [">= 0"]
  spec.add_runtime_dependency "activesupport", [">= 4.0.0"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "shoulda", [">= 0"]
end

