$(->
  menu = $('#navigation-menu')
  menuToggle = $('#js-mobile-menu')
  signUp = $('.sign-up')

  $(document).on 'click', '#js-mobile-menu', (e) ->
    e.preventDefault()
    menu.slideToggle ->
      if menu.is ':hidden'
        menu.removeAttr 'style'

  # underline under the active nav item
  $(document).on 'click', '.nav .nav-link', ->
    $(".nav .nav-link").each ->
      $(this).removeClass "active-nav-item"
    $(this).addClass "active-nav-item"
    $(".nav .more").removeClass "active-nav-item"
)
