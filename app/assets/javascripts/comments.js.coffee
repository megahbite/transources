# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('.comment_text').popover()

  $('.select2').each (i, e) ->
    select = $(e)
    options = 
      allowClear: true
      placeholder: "All"


    if select.hasClass('ajax')
      options.ajax = 
        url: select.data('source')
        dataType: 'json'
        data: (term, page) ->
          q: term
          page: page
          per: 25
        results: (data, page) ->
          results: data.resources
          more: data.total > (page * 25)

      options.dropdownCssClass = "bigdrop"

      if select.data('text')
        options.initSelection = (e, cb) ->
          data = 
            id: e.val()
            text: e.data('text')
          cb data

    select.select2(options)
)