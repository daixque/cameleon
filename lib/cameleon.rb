# -*- coding: utf-8 -*-

require 'cameleon/action'
require 'cameleon/app'

class Cameleon
  @@imported = {}
  
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
  end # class methods
end
