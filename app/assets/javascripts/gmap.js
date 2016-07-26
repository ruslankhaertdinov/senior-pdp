$(document).ready(function(){
  var DEFAULT_COORDS = { lat: 37.773972, lng: -122.431297 };
  var AUTHORS = App.authors;
  var IMAGE_PATH = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m";
  var infoWindows = [];
  var markers = [];
  var timerId = null;
  var $query = $("#query");
  var map;
  var markerCluster;

  function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
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

    drawMarkers(AUTHORS);
    markerCluster = new MarkerClusterer(map, markers, { imagePath: IMAGE_PATH });
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

  function drawMarkers(locations) {
    locations.forEach(function(location, i){
      addMarker(location);
    });
  }

  function bindFilter() {
    $query.on("input", function(){
      clearTimeout(timerId);
      timerId = setTimeout(search, 500);
    });
  }

  function addMarker(location) {
    var marker = new google.maps.Marker({ position: location, map: map });
    markers.push(marker);
    marker.addListener("click", function() {
      closeInfoWindows();
      createInfoWindow(location.info).open(map, marker);
      map.panTo(marker.getPosition());
    });
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

  function search() {
    $.get("/authors/search", { query: $query.val() })
      .done(function(data) {
        redrawMarkers(data.users)
      }).fail(function() {
        console.error("Search error");
      });
  }

  function redrawMarkers(locations) {
    deleteMarkers();
    deleteInfowindows();
    drawMarkers(locations);

    markerCluster.clearMarkers();
    markerCluster.addMarkers(markers);
  }

  function deleteMarkers() {
    clearMarkers();
    markers = [];
  }

  function clearMarkers() {
    markers.forEach(function(marker, i){
      marker.setMap(null);
    })
  }

  function deleteInfowindows() {
    closeInfoWindows();
    infoWindows = [];
  }

  initMap();
  bindFilter();
});
