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

    def switch_filepath
      File.join @base_path, "_switch.rb"
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
      renderer = nil
      if !File.exists?(@base_path)
        if placeholder_dir = on_placeholder_dir("response", req.path)
          @base_path = placeholder_dir
        else
          return [404, {}, ["dir not found: #{@base_path}"]]
        end
      end
      if File.exists?(switch_filepath)
        renderer = Renderer.run_switch(@base_path, req, switch_filepath)
      else
        renderer = Renderer.render_file(@base_path, req)
      end
      renderer.build_response
    end

    def on_placeholder_dir(base_dir_path, target_dir_path, found = false)
      if (!target_dir_path || target_dir_path == "")
        if found
          return base_dir_path
        else
          return nil
        end
      end
      target_dir_path = target_dir_path.gsub(/^\//, '')
      first_dir_name, *rest = target_dir_path.split('/')
      first_dir_path = File.join(base_dir_path, first_dir_name)
      if File.exists?(first_dir_path)
        on_placeholder_dir(first_dir_path, rest.join('/'))
      else
        new_dir = search_placeholder_dir(base_dir_path, first_dir_name)
        if new_dir
          on_placeholder_dir(new_dir, rest.join('/'), true)
        end
      end
    end

    def search_placeholder_dir(base_dir_path, target_dir_name)
      files = Dir.glob(File.join(base_dir_path, '*'))
      # find directory start with $.
      # if there are some directories start with $, use one that found first.
      found = files.find_all{ |f| File.directory?(f) }.find{ |f| ret = f =~ /.*\$([a-zA-Z0-9_\-]*)$/ }
      if (found)
        path_name = $1
        @params[path_name] = target_dir_name
        ret = File.join(base_dir_path, "$" + path_name)
        ret
      end
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
