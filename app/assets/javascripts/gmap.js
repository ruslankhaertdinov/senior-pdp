$(document).ready(function(){
  var DEFAULT_COORDS = { lat: 37.773972, lng: -122.431297 };
  var AUTHORS = App.authors;
  var IMAGE_PATH = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m";
  var infoWindows = [];
  var markers = [];

  function initMap() {
    var map = new google.maps.Map(document.getElementById("map"), {
      center: DEFAULT_COORDS,
      zoom: 7,
      scrollwheel: false
    });

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(data) {
        map.setCenter(parsePosition(data));
      }, function() {
        fetchIPLocation(map);
      });
    } else {
      fetchIPLocation(map);
    }

    drawMarkers(map);
  }

  function fetchIPLocation(map) {
    $.get("/locations/fetch")
      .done(function(data) { map.setCenter(parsePosition(data)); })
      .fail(function() { console.error("Your location could not be fetched."); });
  }

  function parsePosition(data) {
    return {
      lat: data.coords.latitude,
      lng: data.coords.longitude
    };
  }

  function drawMarkers(map) {
    AUTHORS.forEach(function(author, i){
      var marker = new google.maps.Marker({ position: author, map: map });
      markers.push(marker);
      marker.addListener("click", function() {
        closeInfoWindows();
        createInfoWindow(author.info).open(map, marker);
        map.panTo(marker.getPosition());
      });
    });

    var markerCluster = new MarkerClusterer(map, markers, { imagePath: IMAGE_PATH });
  }

  function createInfoWindow(content) {
    var infoWindow = new google.maps.InfoWindow({ content: content });
    infoWindows.push(infoWindow);
    return infoWindow;
  }

  function closeInfoWindows() {
    infoWindows.forEach(function(box, i){
      box.close();
    })
  }

  initMap();
});
