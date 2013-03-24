# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "cameleon"
  gem.homepage = "http://github.com/daixque/cameleon"
  gem.license = "MIT"
  gem.summary = %Q{Cameleon is HTTP mock server framework.}
  gem.description = %Q{Cameleon is HTTP mock server framework based on Rack. You can easily create HTTP server for mockup or stub of external system for your application.}
  gem.email = "daixque@gmail.com"
  gem.authors = ["daixque"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
task :default => :test
