class Cameleon
  class Renderer
    class << self
      def run_switch(base_path, req, switch_path)
        switch_src = File.read switch_path
        Renderer.new(base_path, req).__eval_switch(switch_src)
      end
      
      def render_file(base_path, req, filename)
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
      @params = req.params
      req.body.rewind
      @body = req.body.read
    end
    
    def __eval_switch(switch_src)
      catch(:read) {
        eval switch_src
        render find_default_file
      }
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
    
    def render(filename)
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