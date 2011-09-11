# -*- coding: utf-8 -*-

require 'cameleon'
require 'erubis'
require 'fileutils'

def generate
  unless Cameleon.config
    $stderr.puts "not cameleon home"
    exit(1)
  end
  
  path = ARGV.shift
  dir_path = File.join "response", path
  FileUtils.mkdir_p dir_path
  
  template_dir = File.join Cameleon.root, "/template/generate"
  Dir.glob("#{template_dir}/*").map do |path|
    basename = File.basename(path)
    target_file_path = File.join dir_path, basename
    src = File.read path
    erb = Erubis::Eruby.new src
    body = erb.result(binding)
    File.open(target_file_path, "w") do |f|
      f.puts body
    end
  end
end

generate