# -*- coding: utf-8 -*-

class Cameleon
  class App
    def call(env)
      Cameleon.import File.join(Cameleon.root, "lib/cameleon/action.rb")
      action = Cameleon::Action.new
      req = Rack::Request.new(env)
      action.handle(req)
    end
  end
end