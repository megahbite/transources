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