// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require select2
//= require dataTables/jquery.dataTables
//= require dataTables/extras/dataTables.tableTools
//= require jquery.raty
//= require markerclusterer

//= require handlebars.runtime
//= require_tree ./templates

//= require navigation_bar
//= require alert
//= require resource_rating

$(function() {
  $("select").removeClass('form-control').select2({
    placeholder: "Choose",
    allowClear: true
  });

  window.showInfoWindow = function(map, marker, infoWindow) {
    return function() {
      infoWindow.open(map, marker);
    }
  }

  window.showMarkersCallback = function(mapObj, mc) {
    return function(data){
      var markers = [];
      for (i in data) {
        var r = data[i];
        var w = new google.maps.InfoWindow({
          content: HandlebarsTemplates['resources/info_window'](r)
        });

        var m = new google.maps.Marker({
          //map: mapObj,
          position: new google.maps.LatLng(r.lat, r.long),
          title: r.title
        });

        markers.push(m);

        google.maps.event.addListener(m, 'click', showInfoWindow(mapObj, m, w))
      }
      mc.addMarkers(markers);
    }
  }
});
