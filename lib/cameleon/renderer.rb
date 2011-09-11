# -*- coding: utf-8 -*-
require 'hashie'
require 'json'
require 'nokogiri'

class Cameleon
  class Renderer
    class << self
      def run_switch(base_path, req, switch_path)
        switch_src = File.read switch_path
        Renderer.new(base_path, req).__eval_switch(switch_src)
      end
      
      def render_file(base_path, req, filename = nil)
        catch(:read) {
          Renderer.new(base_path, req).render(filename)
        }
      end
    end
    
    def initialize(base_path, req)
      @base_path = base_path
      @status_code = 200
      @headers = {
        "Content-Type" => "text/plain"
      }
      @req = req
      @params = Hashie::Mash.new req.params
      req.body.rewind
      @body = req.body.read
      @method = req.env["REQUEST_METHOD"]
    end
    
    def __eval_switch(switch_src)
      catch(:read) {
        eval switch_src
        render find_default_file
      }
    end
    
    def params
      @params
    end
    
    def json_body
      @json_body || @json_body = Hashie::Mash.new(JSON.parse(@body))
    end
    
    def xml_body
      @xml_body || @xml_body = Nokogiri::XML::Document.parse(@body)
    end
    
    def build_response
      [@status_code, @headers, [@body]]
    end
    
    def set_header(name, value)
      @headers[name] = value
    end
    
    def status_code(code)
      @status_code = code
    end
    
    def on(*http_methods, &block)
      if http_methods.map { |m| m.to_s.upcase }.include? @method
        yield
      end
    end
    
    def get(&block)
      on(:get, &block)
    end
    
    def put(&block)
      on(:put, &block)
    end
    
    def post(&block)
      on(:post, &block)
    end
    
    def delete(&block)
      on(:delete, &block)
    end
    
    def render(filename = nil)
      filename = find_default_file unless filename
      src = File.read File.join(@base_path, filename)
      erb = Erubis::Eruby.new src
      @body = erb.result(binding)
      throw :read, self
    end
    
    def find_default_file
      Dir.entries(@base_path).find { |f| f =~ /^default/ }
    end
  end
end