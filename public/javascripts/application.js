// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

map = null;

function gmaps_init() {
  var myLatlng = new google.maps.LatLng(37.759991424754361, -122.41636276245117);
  var myOptions = {
      zoom: 14,
      center: myLatlng,
      scrollwheel: false,
      mapTypeControl: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  kickMap();
}
document.observe("dom:loaded", gmaps_init);

function showTagPopup(id) {
    $("edit_tags_" + id).show();
    $("tag_editor_" + id).focus();
}

var Mapp = {
  //toggleView('schedule') = show the element 'schedule_view' and hide other
  // divs matching 'div.mapp_event_view'. also toggle the schedule_button active/inactive
  toggleView: function(tab_to_show) {
    $$('div#mapp_nav img').each(function(b) {
      b.src = b.src.gsub("_active","");
    });
    $(tab_to_show + '_button').src = $(tab_to_show + '_button').src.gsub(".png","_active.png");
    $$('div.mapp_event_view').each(function(e) {
        if (e.id == tab_to_show + '_view')
          e.show();
        else
          e.hide();
    });
  }
};

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
};

// on load, mark stars
document.observe("dom:loaded", function() {
  starredEvents = unescape(readCookie("stars")).split(",");
  starredEvents.each(function(event_id) {
    elem = $('star_' + event_id);
    if(elem) elem.src = "/images/handdrawn/24x24/star_yellow.png";
  });
});
