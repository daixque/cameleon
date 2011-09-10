# -*- coding: utf-8 -*-

require 'cameleon'
require 'hashie'
require 'yaml'

def start(config)
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
  Rack::Handler::WEBrick.run app, :Port => (config.port || 9292)
end

def load_config
  unless File.exist? "./cameleon.yml"
    $stderr.puts "[ERROR] cameleon.yml is not found."
    exit(1)
  end
  config = Hashie::Mash.new YAML.load(File.read("./cameleon.yml"))
end

start load_config