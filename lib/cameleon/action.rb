# -*- coding: utf-8 -*-
require 'erubis'

class Cameleon
  class Action
    def find_default_file
      Dir.entries(@base_path).find { |f| f =~ /^default\./ }
    end
  
    def handle(req)
      @base_path = File.join("response", req.path)
      if req.path == "/"
        @base_path += "_root"
      end
      @params = req.params
      @body = req.body.read
      switch_filepath = File.join @base_path, "_switch.rb"
      renderer = nil
      if !File.exists?(@base_path)
        return [404, {}, ["dir not found: #{@base_path}"]]
      elsif File.exists?(switch_filepath)
        renderer = Renderer.run_switch(@base_path, req, switch_filepath)
      else
        renderer = Renderer.render_file(@base_path, req, find_default_file)
      end
      renderer.build_response
    end
  end
end
