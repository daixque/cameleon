# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'
  
def new
  unless Cameleon.config
    $stderr.puts "not cameleon home"
    exit(1)
  end
  
  base_dir = File.join(Cameleon.root, 'template/gallery')
  Dir.glob("#{base_dir}/*").map do |f|
    FileUtils.cp_r f, "."
  end
end

new