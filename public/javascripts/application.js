// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function gmaps_init() {
  var myLatlng = new google.maps.LatLng(37.759991424754361, -122.41636276245117);
  var myOptions = {
    zoom: 13,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
}

document.observe("dom:loaded", gmaps_init);
