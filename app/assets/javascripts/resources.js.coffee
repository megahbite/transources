# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  # Edit/Create Resource

  window.GetLatLong = ->
    geocoder = new google.maps.Geocoder

    address = "#{$('#resource_address_line_1').val()}, #{$('#resource_address_line_2').val()}, #{$('#resource_town').val()}, #{$('#resource_country').val()}"

    geocoder.geocode { address: address }, (response, status) ->
      if status != google.maps.GeocoderStatus.OK
        message = ""
        switch status
          when google.maps.GeocoderStatus.ZERO_RESULTS then message = "Address not found."
          when google.maps.GeocoderStatus.OVER_QUERY_LIMIT then message = "Exceeded quota of Google Maps requests for today. Try again tomorrow."
          when google.maps.GeocoderStatus.REQUEST_DENIED then message = "Geocoding request denied."
          when google.maps.GeocoderStatus.INVALID_REQUEST then message = "Invalid geocoding request"
          when google.maps.GeocoderStatus.UNKNOWN_ERROR then message = "Unknown error from Google Maps."
        message += "<br />#{response.error_message}" if response.error_message?

        $('#errors').html(HandlebarsTemplate['resources/error']({message: message}))

        return # Show a validation error

      location = response[0].geometry.location

      $('#resource_lat').val(location.lat())
      $('#resource_long').val(location.lng())

      $('.edit_resource').submit()

    false

  $.getJSON('/tags/categories', (data) ->
    $('#resource_category_list').removeClass('form-control').select2 {
      tags: $.map(data, (c) ->
        c.name
      )
      minimumInputLength: 1
      multiple: true
      tokenSeparators: [","]
    }
  )

  # Show Resource

  $('.map').each (i, e) ->
    latLng = new google.maps.LatLng($(e).attr('data-lat'), $(e).attr('data-long'))

    mapOptions = {
      center: latLng,
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false
    }

    map = new google.maps.Map(e, mapOptions)

    markerOptions = {
      map: map,
      position: latLng
    }

    marker = new google.maps.Marker(markerOptions)
)
