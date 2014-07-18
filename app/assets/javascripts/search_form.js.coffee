#Search form
$(->
  #$('.js-location-search').button()

  $('.js-location-autocomplete').each ->
    new google.maps.places.Autocomplete(this)

  $(document).on('click', '#alert-template .close', (e) ->
    $('#alert-template span').remove)

  $(document).on('click', '.js-location-search', (e) ->
    #$(e.target).button('loading')
    geocoder = new google.maps.Geocoder

    address = $('#location').val()

    geocoder.geocode {address: address}, (response, status) ->

      if status != google.maps.GeocoderStatus.OK
        #$(e.target).button('reset')
        ShowAlert('Not a valid address!')
        return

      location = response[0].geometry.location

      radius = $('#radius').val()

      params = "lat=#{location.lat()}&lng=#{location.lng()}&radius=#{radius}"

      categories = $('#categories').val()
      if categories
        for c in categories
          params += "&categories[]=#{c}"

      $.getJSON("/resources/search", params, (data) ->
        #$(e.target).button('reset')
        ShowSearchResults([location.lat(), location.lng()], $('#radius').val(), data))
  )

  ShowAlert = (message) ->
    $('.js-alert').html(HandlebarsTemplates['resources/alert']({ message: message }))

  ShowInfoWindow = (map, marker, infoWindow) ->
    ->
      infoWindow.open(map, marker)

  CalculateScore = (resource) ->
    m = 3
    c = 5
    n = resource.scores.length
    sum = resource.scores.reduce((s, i) ->
      s + Number(i.value)
    , 0)

    ((c * m) + sum) / (c + n)

  ShowSearchResults = (center, radius, resources) ->

    center = new google.maps.LatLng(center[0], center[1])

    mapOptions = {
      center: center,
      zoom: 10,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false
    }

    map = new google.maps.Map($(".js-results-map")[0], mapOptions)

    circleOptions = {
      map: map,
      strokeColor: "#0000FF",
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: "#0000FF",
      fillOpacity: 0.35,
      center: center,
      radius: Math.floor(Number(radius) * 1000)
    }

    circle = new google.maps.Circle(circleOptions)

    $(".results-list").empty()

    if resources.length <= 0
      ShowAlert('No results')
      return

    for r in resources
      w = new google.maps.InfoWindow({
          content: HandlebarsTemplates['resources/info_window'](r)
        })

      m = new google.maps.Marker({
          map: map,
          position: new google.maps.LatLng(r.lat, r.long),
          title: r.title
        })

      r.score = CalculateScore(r)

      google.maps.event.addListener(m, 'click', ShowInfoWindow(map, m, w))

      $(".results-list").append(HandlebarsTemplates['resources/result'](r))
      $('.resource-rating-show').trigger('update-score')

)
