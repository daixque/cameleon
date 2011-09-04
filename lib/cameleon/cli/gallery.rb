# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'
  
def new
  base_dir = File.join(Cameleon.root, 'template/gallery')
  Dir.glob("#{base_dir}/*").map do |f|
    FileUtils.cp_r f, "."
  end
end

new