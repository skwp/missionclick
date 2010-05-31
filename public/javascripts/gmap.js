// ========================================
// = Maps events using Google Maps Api v3 =
// ========================================

// main kick off function for gMaps
function kickMap() {
    var yelp_api_key = "12YsGWt2MdFgkrgXH4rzQA";

    // setup the map 
    var map = new google.maps.Map($("map_canvas"), {
        zoom: 14,
        center: new google.maps.LatLng(37.77, -122.41),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false,
        mapTypeControl: false
    });
    var bounds = new google.maps.LatLngBounds();

    var temporal_icon = {
        today: '/images/gmap_icons/red_dot.png',
        tomorrow: '/images/gmap_icons/yellow_dot.png',
        later: '/images/gmap_icons/teal_dot.png'
    };

    // 
    function addEvents(_events, temporal) {
      if(_events)
        _events.each(function(_event) { addEvent(_event.event, temporal); });
    }

    // TODO hack :: not show already mapped venues
    var mapped_venues = {};

    function addEvent(_event, temporal) {
        var event_id = _event.venue.id;
        if (!mapped_venues[event_id]) {
            addEventMarker(_event, temporal_icon[temporal]);
            mapped_venues[event_id] = 1;
        }
    }

    // only one instance of infowindow :: jumps around markers
    var infowindow = new google.maps.InfoWindow();
    google.maps.event.addListener(infowindow, 'closeclick', function() {
        map.fitBounds(bounds);      // repan after panning to fit infowindow
    });
    
    // infowindow content template + factory
    // TODO read from a separate file?
    var infowindow_template = new Template(
        '<div class="mapMarker">#{event_title}<hr/><div class="businessinfo">#{event_start_time}</div></div>'
    );
    function makeInfowindowContent(_event) {
        return infowindow_template.evaluate({
            event_title: _event.title,
            event_start_time: _event.start_time
        })
    }

    // adds event marker for an event to the map
    function addEventMarker(_event, icon) {
        var latlng = new google.maps.LatLng(_event.venue.lat, _event.venue.lng);
        var marker = new google.maps.Marker({
              position: latlng,
              map: map,
              icon: icon,
              title: _event.title
        });
        bounds.extend(latlng);
        google.maps.event.addListener(marker, 'click', function() {
            infowindow.setContent(makeInfowindowContent(_event));
            infowindow.open(map, marker);
        });
    }

    // add all events
    ['today', 'tomorrow', 'later'].each(function(key) {
        addEvents(events[key], key);
    });
    map.fitBounds(bounds);

}
