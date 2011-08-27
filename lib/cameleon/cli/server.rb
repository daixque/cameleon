# -*- coding: utf-8 -*-

require 'cameleon'

version = ">= 0"

if ARGV.first =~ /^_(.*)_$/ and Gem::Version.correct? $1 then
  version = $1
  ARGV.shift
end

gem 'rack', version
require 'rack'
require 'rack/builder'
require 'rack/handler/webrick'
app = Rack::Builder.new {
  use Rack::Chunked
  run Cameleon::App.new
}
trap(:INT) {
  Rack::Handler::WEBrick.shutdown
}
Rack::Handler::WEBrick.run app, :Port => 9292
