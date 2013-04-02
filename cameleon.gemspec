# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cameleon}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{daixque}]
  s.date = %q{2013-04-04}
  s.description = %q{Cameleon is HTTP mock server framework based on Rack. You can easily create HTTP server for mockup or stub of external system for your application.}
  s.email = %q{daixque@gmail.com}
  s.executables = [%q{cameleon}]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/cameleon",
    "cameleon.gemspec",
    "lib/cameleon.rb",
    "lib/cameleon/action.rb",
    "lib/cameleon/app.rb",
    "lib/cameleon/cli.rb",
    "lib/cameleon/cli/gallery.rb",
    "lib/cameleon/cli/generate.rb",
    "lib/cameleon/cli/new.rb",
    "lib/cameleon/cli/server.rb",
    "lib/cameleon/renderer.rb",
    "template/gallery/response/gallery/erb/default.txt",
    "template/gallery/response/gallery/json/_switch.rb",
    "template/gallery/response/gallery/json/bar.json",
    "template/gallery/response/gallery/json/default.json",
    "template/gallery/response/gallery/json/foo.json",
    "template/gallery/response/gallery/params/_switch.rb",
    "template/gallery/response/gallery/params/bar.txt",
    "template/gallery/response/gallery/params/default.txt",
    "template/gallery/response/gallery/params/foo.txt",
    "template/gallery/response/gallery/rest/_switch.rb",
    "template/gallery/response/gallery/rest/delete.txt",
    "template/gallery/response/gallery/rest/get.txt",
    "template/gallery/response/gallery/rest/put_or_post.txt",
    "template/gallery/response/gallery/simple/default.txt",
    "template/gallery/response/gallery/xml/_switch.rb",
    "template/gallery/response/gallery/xml/bar.xml",
    "template/gallery/response/gallery/xml/default.xml",
    "template/gallery/response/gallery/xml/foo.xml",
    "template/generate/_switch.rb",
    "template/generate/default",
    "template/new/cameleon.yml",
    "template/new/response/_root/_switch.rb",
    "template/new/response/_root/default",
    "test/helper.rb",
    "test/test_cameleon.rb"
  ]
  s.homepage = %q{http://github.com/daixque/cameleon}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Cameleon is HTTP mock server framework.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<erubis>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<hashie>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<json-schema>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
    else
      s.add_dependency(%q<erubis>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<hashie>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<json-schema>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    end
  else
    s.add_dependency(%q<erubis>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<hashie>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<json-schema>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
  end
end

