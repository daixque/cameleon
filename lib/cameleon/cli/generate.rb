# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'

def generate
  path = ARGV.shift
  dir_path = File.join "response", path
  FileUtils.mkdir_p dir_path
  
  file_path = File.join dir_path, "default"
  File.open(file_path, "w") do |f|
    f.puts "edit me: #{file_path}"
  end
end

generate