# -*- coding: utf-8 -*-

require 'cameleon/app'
require 'hashie'
require 'yaml'
require 'active_support/all'

class Cameleon
  @@imported = {}
  @@config = nil
  
  class << self
    def root
      File.join File.dirname(__FILE__), "../"
    end
    
    def import(file)
      raise "file not found" unless File.exists? file
      crnt_timestamp = File::stat(file).mtime
      if @@imported.include?(file)
        prev_timestamp = @@imported[file]
        if (crnt_timestamp > prev_timestamp)
          @@imported[file] = crnt_timestamp
          load(file)
          return true
        else
          return false
        end
      else
        @@imported[file] = crnt_timestamp
        load(file)
        return true
      end
    end # import
    
    def config
      @config ||= begin
        path = "./cameleon.yml"
        unless File.exist? path
          return nil
        end
        Hashie::Mash.new YAML.load(File.read(path))
      end
      load_setup
      @config
    end # config

    def load_setup
      path = './initializer.rb'
      require path if File.exist? path
    end

    # call from initializer.rb
    def setup(&block)
      block.call(@config)
    end

    def version
      File.read(File.join(Cameleon.root, "VERSION")).chomp
    end
  end # class methods
end
