module MotionHybrid
  module Updatable

    private

    def reload_dependents
      PM.logger.debug "reloading!"
      @needs_reload = false
      dependents.map(&:stop)
      dependents.map(&:reload)
    end

    # Inefficient, but will do for now
    def dependents
      dependents = all_views - [self]
      dependents = dependents | parent_screens
      dependents
    end

    def all_views
      app_delegate.window.rootViewController.viewControllers.map(&:viewControllers).flatten
    end

    def needs_reload?
      @needs_reload
    end

    def parent_screens
      parent_screens = []
      screen = self
      while screen = screen.parent_screen
        parent_screens << screen
      end
      parent_screens
    end

  end
end
