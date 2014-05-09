# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('#comments_table').dataTable
    sPaginationType: "bootstrap"
    sDom: 'T<"clearfix"><""l"F"f>t<p>'
    oLanguage:
      sSearch: ""
    fnPreDrawCallback: ->
      $('.dataTables_filter input').addClass 'form-control input-sm'
      $('.dataTables_filter input').css 'width', '200px'
      $('.dataTables_filter input').attr 'placeholder', 'Search'
      $('.dataTables_length select').addClass 'form-control input-sm'
      $('.dataTables_length select').css 'width', '75px'
    oTableTools:
      sRowSelect: "multi"
      aButtons: [
        "select_all",
        "select_none",
        {
          sExtends: "text"
          sButtonText: "Spam selected"
          sButtonClass: "DTTT_disabled"
          fnClick: (button) ->
            return if $(button).hasClass('DTTT_disabled')
            selected = this.fnGetSelected()
            stack = []
            $.each(selected, (i, node) ->
              if ($(node).data('spam') == undefined)
                stack.push $(node).data('id')
            )
            $.get("/comments/spam", {ids: stack}).always(-> location.reload()) if stack.length > 0
          fnSelect: (button)->
            if this.fnGetSelected().length == 0
              $(button).addClass('DTTT_disabled')
            else
              $(button).removeClass('DTTT_disabled')
        },
        {
          sExtends: "text"
          sButtonText: "Unspam selected"
          sButtonClass: "DTTT_disabled"
          fnClick: (button) ->
            return if $(button).hasClass('DTTT_disabled')
            selected = this.fnGetSelected()
            stack = []
            $.each(selected, (i, node) ->
              if ($(node).data('spam') != undefined)
                stack.push $(node).data('id')
            )
            $.get("/comments/ham", {ids: stack}).always(-> location.reload()) if stack.length > 0
          fnSelect: (button)->
            if this.fnGetSelected().length == 0
              $(button).addClass('DTTT_disabled')
            else
              $(button).removeClass('DTTT_disabled')
        },
      ]

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
