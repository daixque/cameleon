# -*- coding: utf-8 -*-
# command line interface for cameleon

require 'cameleon'
require 'optparse'

def parse_options(argv)
  OptionParser.new { |opt|
    opt.on("-v", "--version") {
      version = File.read "#{Cameleon.root}/VERSION"
      puts "cameleon #{version}"
      exit(0)
    }
    opt.on("-h", "--help") {
      usage
      exit(0)
    }
    opt.parse! argv
  }
end

def usage
    puts usage_text = <<-"USAGE"
Cameleon - HTTP mock server framework.

Usage:
  cameleon [option] command [args]

Commands:
  new:             create new dummy application
  server:          launch server
  generate path:   generate scaffold for path
  
Options:
  -v:  show version
USAGE
end

def run
  aliases = {
    's' => 'server',
    'g' => 'generate'
  }
  
  parse_options ARGV
  
  command = ARGV.shift
  command = aliases[command] || command
  case command
  when 'server'
    require 'cameleon/cli/server'
  when 'new'
    require 'cameleon/cli/new'
  when 'generate'
    require 'cameleon/cli/generate'
  when 'gallery'
    require 'cameleon/cli/gallery'
  when 'help'
    usage
  else
    puts "unknown command: #{command}."
    puts "'cameleon help' for usage."
  end
end

run