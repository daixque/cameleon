# -*- coding: utf-8 -*-
require 'erubis'
require 'json-schema'

class Cameleon
  class ValidationError < Exception
    def initialize(msg)
      super(msg)
    end
  end

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
      if ["POST", "PUT"].include? req.request_method
        begin
          validate_request_body
        rescue Cameleon::ValidationError => e
          return [400, {}, [e.message]]
        end
      end
      switch_filepath = File.join @base_path, "_switch.rb"
      renderer = nil
      if !File.exists?(@base_path)
        return [404, {}, ["dir not found: #{@base_path}"]]
      elsif File.exists?(switch_filepath)
        renderer = Renderer.run_switch(@base_path, req, switch_filepath)
      else
        renderer = Renderer.render_file(@base_path, req)
      end
      renderer.build_response
    end

    def validate_request_body
      validation_type = Cameleon.config.validation && Cameleon.config.validation.type
      case validation_type
      when "json"
        validate_json
      when nil
      else
        raise "unknown validation type '#{validation_type}' in config.yml"
      end
    end

    def validate_json
      schema_filepath = File.join(@base_path, "request.schema.json")
      if File.exists? schema_filepath
        begin
          schema = JSON.parse File.read(schema_filepath)
          JSON::Validator.validate!(schema, @body)
        rescue JSON::Schema::ValidationError => e
          error_body = {"error" => e.message}.to_json
          raise Cameleon::ValidationError.new(error_body)
        end
      end
    end
  end
end
