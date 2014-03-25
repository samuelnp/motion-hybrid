class AppDelegate < PM::Delegate
  def on_load(app, options)
    return true if App.environment == 'test'
    @screen_1 = BaseScreen.new(nav_bar: true)
    @screen_2 = BaseScreen.new(nav_bar: true)

    @screen_1.set_tab_bar_item title: 'Balvig', system_icon: :more
    @screen_2.set_tab_bar_item title: 'Rubymotion', system_icon: :favorites

    open_tab_bar @screen_1, @screen_2

    BaseScreen.sync_sessions do
      @screen_1.path = '/balvig'
      @screen_2.path = '/rubymotion'
    end
  end
end
