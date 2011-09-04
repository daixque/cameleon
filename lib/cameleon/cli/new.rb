# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'
  
def new
  project_name = ARGV.shift
  FileUtils.mkdir_p project_name
  base_dir = File.join(Cameleon.root, 'template/new')
  Dir.glob("#{base_dir}/*").map do |f|
    FileUtils.cp_r f, project_name
  end
end

new