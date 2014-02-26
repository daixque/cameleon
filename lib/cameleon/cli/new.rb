# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'
require 'erubis'
  
def new
  project_name = ARGV.shift
  FileUtils.mkdir_p project_name
  base_dir = File.join(Cameleon.root, 'template/new')
  Dir.glob("#{base_dir}/*").map do |f|
    if File.file? f
      src = File.read f
      erb = Erubis::Eruby.new src
      text = erb.result(binding)
      basename = File.basename(f)
      File.open(File.join(project_name, basename), 'w') do |out|
        out.write text
      end
    elsif File.directory? f
      FileUtils.cp_r f, project_name
    end
  end
end

new