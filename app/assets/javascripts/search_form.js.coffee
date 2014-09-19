#Search form
$(->
  $('.js-location-autocomplete').each ->
    new google.maps.places.Autocomplete(this)

  $(document).on('click', '#alert-template .close', (e) ->
    $('#alert-template span').remove)

  $(document).on('click', '.js-location-search', (e) ->
    e.preventDefault()
    geocoder = new google.maps.Geocoder

    address = $('#location').val()

    geocoder.geocode {address: address}, (response, status) ->

      if status != google.maps.GeocoderStatus.OK
        showAlert('Not a valid address!')
        return

      location = response[0].geometry.location

      radius = $('#radius').val()

      params = "location=#{encodeURIComponent(address)}&lat=#{location.lat()}&lng=#{location.lng()}&radius=#{radius}"

      categories = $('#categories').val()
      if categories
        for c in categories
          params += "&categories[]=#{encodeURIComponent(c)}"

      window.location = "/resources/search?#{params}"
      # $.getJSON("/resources/search", params, (data) ->
      #   #$(e.target).button('reset')
      #   ShowSearchResults([location.lat(), location.lng()], $('#radius').val(), data))
  )

  showAlert = (message) ->
    $('.js-alert').html(HandlebarsTemplates['resources/alert']({ message: message }))

  showInfoWindow = (map, marker, infoWindow) ->
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

  showMarkersCallback = (mapObj) ->
    (data) ->
      for r in data
        w = new google.maps.InfoWindow(
          content: HandlebarsTemplates['resources/info_window'](r)
        )

        m = new google.maps.Marker(
          map: mapObj
          position: new google.maps.LatLng(r.lat, r.long)
          title: r.title
        )

        google.maps.event.addListener(m, 'click', showInfoWindow(mapObj, m, w))

  if $(".js-results-map").length > 0
    for map in $('.js-results-map')
      center = new google.maps.LatLng $(map).data('lat'), $(map).data('lng')

      mapOptions =
        center: center
        zoom: 10
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      mapObj = new google.maps.Map(map, mapOptions)

      circleOptions =
        map: mapObj
        strokeColor: '#0000FF'
        strokeOpacity: 0.8
        strokeWeight: 2
        fillColor: '#0000FF'
        fillOpacity: 0.35
        center: center
        radius: Math.floor(Number($(map).data('radius')) * 1000)

      circle = new google.maps.Circle(circleOptions)

      $.getJSON "/resources/search", window.location.search.slice(1), showMarkersCallback(mapObj)
)
