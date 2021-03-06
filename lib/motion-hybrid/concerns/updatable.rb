module MotionHybrid
  module Updatable

    def reload!
      stop
      stop_transitions
      reload
    end

    def reload_dependents
      @needs_reload = false
      dependents.map(&:reload!)
    end

    private

      def dependents
        parent_screens
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
