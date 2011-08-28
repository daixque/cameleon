# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'

def new
  project_name = ARGV.shift
  FileUtils.mkdir project_name
  FileUtils.cp_r File.join(Cameleon.root, 'response'), project_name
end

new