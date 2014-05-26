module MotionHybrid
  class Bridge
    PATH = NSBundle.mainBundle.resourcePath + '/jquery.motion-hybrid.js'
    JS_LIB = File.open(PATH).read

    def initialize(screen)
      @screen = screen
      @screen.evaluate(JS_LIB)
    end

    def click(target)
      js_api("clicked('#{target}')")
    end

    def click_child(parent, child_index)
      child_index = remap_index(child_index)
      js_api("clicked('#{parent}', #{child_index})") if child_index > 0
    end

    private

    def bridge_hash
      @bridge_hash ||= Dish BW::JSON.parse(bridge_json)
    end

    def bridge_json
      js_api('getParams()').presence || '{}'
    end

    def method_missing(method)
      bridge_hash.send(method)
    end

    #  iOS button order and actual order of buttons on screen are not the same
    def remap_index(index)
      if index == nav_bar_right_button.options.length - 1
        0
      else
        index + 1
      end
    end

    def js_api(command)
      @screen.evaluate("MotionHybrid.#{command};").to_s
    end

  end
end