//YELP API KEY
var YWSID = "12YsGWt2MdFgkrgXH4rzQA"; // common required parameter (api key)

/*
 * Construct the URL to call for the API request
 */
function constructYelpURL() {
  //category list from http://www.yelp.com/developers/documentation/category_list
  var URL = "http://api.yelp.com/" +
    "business_review_search?"+
    "callback=" + "handleResults" +
    "&category=bars+internetcafe+galleries+movietheaters+festivals+jazzandblues+musicvenues+theater+wineries" + 
    "&num_biz_requested=10" +
    "&location=Mission%2C+San+Francisco%2C+CA"+ 
    "&ywsid=" + YWSID;
  return encodeURI(URL);
}

/*
 * Called on the form submission: updates the map by
 * placing markers on it at the appropriate places
 */
function updateMap() {
  // turn on spinner animation
  //document.getElementById("spinner").style.visibility = 'visible';

  var yelpRequestURL = constructYelpURL();

  /* clear existing markers V2 ONLY */
  // map.clearOverlays(); 

  /* do the api request */
  var script = document.createElement('script');
  script.src = yelpRequestURL;
  script.type = 'text/javascript';
  var head = document.getElementsByTagName('head').item(0);
  head.appendChild(script);
  return false;
}

/*
 * If a sucessful API response is received, place
 * markers on the map.  If not, display an error.
 */
function handleResults(data) {
  // turn off spinner animation
  // document.getElementById("spinner").style.visibility = 'hidden';
  if(data.message.text == "OK") {
    if (data.businesses.length == 0) {
      alert("Error: No reviews for businesses were found near that location");
      return;
    }
    for(var i=0; i<data.businesses.length; i++) {
      biz = data.businesses[i];
      createMarker(biz, new google.maps.LatLng(biz.latitude, biz.longitude), i);
    }
    var listings ='';
    for(var i=0; i<data.businesses.length; i++) {
      biz = data.businesses[i];
      listings = listings + generateSidebar(biz);
    }
    //TODO
    //document.getElementById('listingsBox').innerHTML = listings;
  }
  else {
    alert("Error: " + data.message.text);
  }
}

/*
 * Formats and returns the Info Window HTML 
 * (displayed in a balloon when a marker is clicked)
 */
function generateInfoWindowHtml(biz) {
    var text = '<div class="mapMarker">';

    // image and rating
    text += '<img class="businessimage" src="'+biz.photo_url+'"/>';

    // div start
    text += '<div class="businessinfo">';
    // name/url
    text += '<a href="'+biz.url+'" target="_blank">'+biz.name+'</a><br/>';
    // stars
    text += '<img class="ratingsimage" src="'+biz.rating_img_url_small+'"/>&nbsp;based&nbsp;on&nbsp;';
    // reviews
    text += biz.review_count + '&nbsp;reviews<br/><br />';
    // categories
    text += formatCategories(biz.categories);
    // neighborhoods
    if(biz.neighborhoods.length)
        text += formatNeighborhoods(biz.neighborhoods);
    // address
    text += biz.address1 + '<br/>';
    // address2
    if(biz.address2.length) 
        text += biz.address2+ '<br/>';
    // city, state and zip
    text += biz.city + ',&nbsp;' + biz.state + '&nbsp;' + biz.zip + '<br/>';
    // phone number
    if(biz.phone.length)
        text += formatPhoneNumber(biz.phone);
    // Read the reviews
    text += '<br/><a href="'+biz.url+'" target="_blank">Read the reviews »</a><br/>';
    // div end
    text += '</div></div>'
    return text;
}

function generateSidebar(biz) {
    var text = '<div class="sidebar" align="left">';

    // div start
    text += '<div class="businessinfo1">';
    // name/url
    text += '<a href="'+biz.url+'" target="_blank" style="font-weight:bold;">'+biz.name+'</a><br/>';
    // stars
    text += '<span class="small"><img class="ratingsimage1" src="'+biz.rating_img_url_small+'"/> based&nbsp;on&nbsp;';
    // reviews
    text += biz.review_count + '&nbsp;reviews';
// Read the reviews
    text += '<br/><a href="'+biz.url+'" target="_blank">Read the reviews »</a><br/>';
    // categories
    // address
    text += '<br/><strong>Address:</strong><br/>' + biz.address1 + '<br/>';
    // address2
    if(biz.address2.length) 
        text += biz.address2+ '<br/>';
    // city, state and zip
    text += biz.city + ',&nbsp;' + biz.state + '&nbsp;' + biz.zip + '<br/>';
    // phone number
    if(biz.phone.length)
        text += formatPhoneNumber(biz.phone) + '<br/>';
   // neighborhoods
    if(biz.neighborhoods.length)
        text += formatNeighborhoods(biz.neighborhoods);
    
    // div end
    text += '</span></div></div>'
    return text;
}

/*
 * Formats the categories HTML
 */
function formatCategories(cats) {
    var s = 'Categories: ';
    for(var i=0; i<cats.length; i++) {
        s+= cats[i].name;
        if(i != cats.length-1) s += ', ';
    }
    s += '<br/>';
    return s;
}

/*
 * Formats the neighborhoods HTML
 */
function formatNeighborhoods(neighborhoods) {
    s = 'Neighborhoods: ';
    for(var i=0; i<neighborhoods.length; i++) {
        s += '<a href="' + neighborhoods[i].url + '" target="_blank">' + neighborhoods[i].name + '</a>';
        if (i != neighborhoods.length-1) s += ', ';
    }
    s += '<br/>';
    return s;
}

/*
 * Formats the phone number HTML
 */
function formatPhoneNumber(num) {
    if(num.length != 10) return '';
    return '(' + num.slice(0,3) + ') ' + num.slice(3,6) + '-' + num.slice(6,10) + '<br/>';
}

/*
 * Creates a marker for the given business and point
 */
function createMarker(biz, point, markerNum) {
    var marker = new google.maps.Marker({position: point, map: map});
    marker.setMap(map);

    var infowindow = new google.maps.InfoWindow({
        content: generateInfoWindowHtml(biz),
        maxWidth: 400
    });

    google.maps.event.addListener(marker, "click", function() {
        infowindow.open(map, marker);
    });
}
