# -*- coding: utf-8 -*-

require 'erubis'

class Cameleon
  class Action
    def initialize
      @status_code = 200
      @headers = {
        "Content-Type" => "text/plain"
      }
    end
    
    def set_header(name, value)
      @headers[name] = value
    end
    
    def status_code(code)
      @status_code = code
    end
    
    def eval_switch(switch_filepath)
      src = File.read(switch_filepath)
      body = catch(:read) {
        eval src
        render find_default_file
      }
    end
    
    def __render(filename)
      body = catch(:read) {
        render filename
      }
    end
    
    def render(filename)
      src = File.read File.join(@base_path, filename)
      erb = Erubis::Eruby.new src
      body = erb.result(binding)
      throw :read, body
    end
    
    def find_default_file
      Dir.entries(@base_path).find { |f| f =~ /^default/ }
    end
  
    def handle(req)
      @base_path = File.join("response", req.path)
      if req.path == "/"
        @base_path += "_root"
      end
      @params = req.params
      @body = req.body.read
      switch_filepath = File.join @base_path, "switch.rb"
      content = ""
      if !File.exists?(@base_path)
        content = "dir not found: #{@base_path}"
      elsif File.exists?(switch_filepath)
        content = eval_switch switch_filepath
      else
        content = __render find_default_file
      end
      [@status_code, @headers, [content]]
    end
  end
end
