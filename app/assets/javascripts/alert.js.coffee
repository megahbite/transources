$(->
  $(document).on 'click', 'a[data-dismiss],button[data-dismiss]', (e) ->
    target = $(e.currentTarget)
    target.parents(".#{target.data('dismiss')}").first().slideUp();
)
