class window.MotionRails
  @getParams: ->
    bridge = $('#motion_rails_bridge')

    params = {}
    params.title = bridge.find('h1').text()
    params.subtitle = bridge.find('h2').text()
    params.nav_bar_left_button = parseButton bridge.find('#nav_bar_left_button')
    params.nav_bar_right_button = parseButton bridge.find('#nav_bar_right_button')
    params.flash = parseFlash bridge.find('.flash')

    params.refreshable = $('[data-refreshable]').length > 0

    JSON.stringify params

  parseButton = (button) ->
    { link: button.attr('href'), options: button.children().map(-> this.innerText).get() } if button.length

  parseFlash = (flash) ->
    { title: flash.find('h3').text() || flash.text().trim(), subtitle: flash.find('p').text() } if flash.length

  @clicked: (target, childIndex) ->
    target = $("##{target}")
    target = target.children() if childIndex
    target.get(childIndex || 0).click()

jQuery ->
  agent = window.navigator.userAgent
  if agent.indexOf('iPhone') > 0 && agent.indexOf('Safari') < 0
    document.location.href = 'motionrails://ready'
  else
    $('body').addClass('motion_rails_dev')
