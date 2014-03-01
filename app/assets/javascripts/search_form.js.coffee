#Search form
$(->
  $('.js-location-search').button()

  $('.js-location-autocomplete').each ->
    new google.maps.places.Autocomplete(this)

  $(document).on('click', '#alert-template .close', (e) ->
    $('#alert-template span').remove)

  $(document).on('click', '.js-location-search', (e) ->
    $(e.target).button('loading')
    geocoder = new google.maps.Geocoder

    address = $('#location').val()

    geocoder.geocode {address: address}, (response, status) ->
      
      if status != google.maps.GeocoderStatus.OK
        $(e.target).button('reset')
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
        $(e.target).button('reset')
        ShowSearchResults([location.lat(), location.lng()], $('#radius').val(), data))
  )

  ShowAlert = (message) ->
    $('#alert-template span').remove()
    $('#alert-template button').after("<span>#{message}</span>")
    $('#alert-template').fadeIn('slow')

  ShowInfoWindow = (map, marker, infoWindow)->
    ->
      infoWindow.open(map, marker)

  ShowSearchResults = (center, radius, resources) ->
    
    center = new google.maps.LatLng(center[0], center[1])

    mapOptions = {
      center: center,
      zoom: 10,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false
    }

    map = new google.maps.Map($(".results-map")[0], mapOptions)

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
          content: "<h3>#{r.title}</h3>
                    <p><a href='/resources/#{r.id}'>Go to resource &gt;&gt;</a></p>
                    <address>
                      #{r.address_line_1}<br>
                      #{r.address_line_2}<br>
                      #{r.town}<br>
                      #{r.country}
                    </address>
                    <p>#{r.description}</p>"
        })

      m = new google.maps.Marker({
          map: map,
          position: new google.maps.LatLng(r.lat, r.long),
          title: r.title
        })

      google.maps.event.addListener(m, 'click', ShowInfoWindow(map, m, w))

      category_links = []

      for c in r.categories
        category_links.push("<a href='/resources/tag/#{c.name}'>#{c.name}</a>")

      $(".results-list").append(
        "<li>
          <p><a href='/resources/#{r.id}'><strong>#{r.title}</strong></a><br>
          <small>Categories: #{category_links.join(', ')}</small></p>
        </li>")

)