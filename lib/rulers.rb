require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

module Rulers
  class Application
    def call(env)
      # hacky way to deal with favicon
      if env['PATH_INFO'] == '/favicon.ico'
        return [
          404,
          {'Content-Type' => 'text/html'},
          []
        ]
      end

      # get controller and action from the url
      klass, act = get_controller_and_action(env)
      # make new controller
      controller = klass.new(env)
      # send the new controller an action
      text = controller.send(act)

      [
        200,
        {'Content-Type' => 'text/html'},
        [text]
      ]
    end
  end
end
