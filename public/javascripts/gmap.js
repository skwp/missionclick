// ========================================
// = Maps events using Google Maps Api v3 =
// ========================================

// main kick off function for gMaps
function kickMap() {
    var yelp_api_key = "12YsGWt2MdFgkrgXH4rzQA";

    // setup the map 
    var map = new google.maps.Map($("map_canvas"), {
        zoom: 14,
        center: new google.maps.LatLng(37.757, -122.41),
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

    var EventfulVenue = Class.create({
        initialize: function(venue) { 
            this.venue = venue;
            this.temporal_events = {
                today: [],
                tomorrow: [],
                later: []
            };
        },
        addEvent: function(_event, temporal) {
            this.temporal_events[temporal].push(_event);
        },
        getIcon: function() {
            var temporals = ['today', 'tomorrow', 'later'];
            for (var i = 0, len = temporals.length; i < len; i++){
                var temporal = temporals[i];
                if (this.temporal_events[temporal].length > 0)
                    return temporal_icon[temporal];
            }
        },
        getEvents: function() {
            var temporals = ['today', 'tomorrow', 'later'];
            var results = [];
            // native loops for max perf :: this is a frequent operation
            for (var ti = 0, tl = temporals.length; ti<tl; ti++){
                var events = this.temporal_events[temporals[ti]];
                for (var ei = 0, el = events.length; ei<el; ei++)
                    results.push(events[ei]);
            }
            return results;
        }
    });

    var VenueContainer = {
        venues: {},
        get_or_create: function(venue) {
            var venue_id = venue.id;
            if (!this.venues[venue_id])
                this.venues[venue_id] = new EventfulVenue(venue);
            return this.venues[venue_id];
        }
    };

    function addEvents(_events, temporal) {
      if(_events)
        _events.each(function(_event) {
            var _event = _event.event;
            VenueContainer.get_or_create(_event.venue).addEvent(_event, temporal);
        });
    }

    function mapVenues() {
        for (var venue_id in VenueContainer.venues) {
            var eventfulVenue = VenueContainer.venues[venue_id];
            addVenueMarker(eventfulVenue);
        }
    }

    // only one instance of infowindow :: jumps around markers
    var infowindow = new google.maps.InfoWindow();

    // commented out by yan. makes the fucking thing jump 
    /*
    google.maps.event.addListener(infowindow, 'closeclick', function() {
        map.fitBounds(bounds);      // repan after panning to fit infowindow
    });
    */
    
    // infowindow content template + factory
    // TODO read from a separate file?
    var infowindow_template = new Template(
        '<div class="mapMarker">#{events}</div>'
    );
    var event_entry_template = new Template(
        '#{event_title}<div class="businessinfo">#{event_start_time}</div>'
    );
    function makeInfowindowContent(events) {
        var entries = events.collect(function(_event){
            return event_entry_template.evaluate({
                event_title: _event.title,
                event_start_time: _event.formatted_start_time
            });
        }).join('<hr />');
        return infowindow_template.evaluate({ events: entries });
    }

    // adds event marker for an event to the map
    function addVenueMarker(eventfulVenue) {
        var latlng = new google.maps.LatLng(eventfulVenue.venue.lat, eventfulVenue.venue.lng);
        var marker = new google.maps.Marker({
              position: latlng,
              map: map,
              icon: eventfulVenue.getIcon(),
              title: eventfulVenue.venue.name
        });
        bounds.extend(latlng);
        google.maps.event.addListener(marker, 'click', function() {
            infowindow.setContent(makeInfowindowContent(eventfulVenue.getEvents()));
            infowindow.open(map, marker);
        });
    }

    // load events into structures
    ['today', 'tomorrow', 'later'].each(function(key) {
        addEvents(events[key], key);
    });

    // map all venues
    mapVenues();

    // commented out by yan - it's a hack but at least it won't jump 
    // to god knows where. the default lat/lng set above is sufficient
    // for mapp at least
    //    map.fitBounds(bounds);

}
