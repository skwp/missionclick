function kickMap() {
    var yelp_api_key = "12YsGWt2MdFgkrgXH4rzQA";
    
    var map = new google.maps.Map($("map_canvas"), {
        zoom: 10,
        center: new google.maps.LatLng(37.77, -122.41),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var bounds = new google.maps.LatLngBounds()

    var temporal_icon = {
        today: '/images/gmap_icons/red_dot.png',
        tomorrow: '/images/gmap_icons/orange_dot.png',
        later: '/images/gmap_icons/teal_dot.png'
    };

    function addEvents(_events, temporal) {
        _events.each( function(_event) {
            addEvent(_event.event, temporal);
        });
    }

    function addEvent(_event, temporal) {
        var marker = addEventMarker(_event, temporal_icon[temporal]);
        addEventInfoWindow(_event, marker);
    }

    function addEventMarker(_event, icon) {
        var latlng = new google.maps.LatLng(_event.venue.lat, _event.venue.lng);
        bounds.extend(latlng);
        return new google.maps.Marker({
              position: latlng,
              map: map,
              icon: icon,
              title: _event.title
        });
    }

    function addEventInfoWindow(_event, marker) {
        var infowindow = new google.maps.InfoWindow();
        google.maps.event.addListener(marker, 'click', function() {
            infowindow.open(map, marker);
            infowindow.setContent(_event.title);
            lookupYelp(_event.venue);
        });
    }

    // addEvents(events.later, 'later');
    // addEvents(events.tomorrow, 'tomorrow');
    addEvents(events.today, 'today');
    map.fitBounds(bounds);

}