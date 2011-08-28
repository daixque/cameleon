# -*- coding: utf-8 -*-

require 'cameleon'
require 'fileutils'

def generate
  path = ARGV.shift
  dir_path = File.join "response", path
  FileUtils.mkdir_p dir_path
end

generate