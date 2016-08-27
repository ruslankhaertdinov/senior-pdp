App.Components ||= {}

class App.Components.Gmap
  constructor: (@el) ->
    @_bindUI()
    @_initDefaultVars()
    @_initMap()
    @_bindFilter()

  _bindUI: ->
    @ui =
      $query: $("#query")

  _initDefaultVars: ->
    @defaultCoords = { lat: 37.773972, lng: -122.431297 }
    @markers = []
    @infoWindows = []
    @imagePath = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m"
    @authors = App.authors

  _initMap: ->
    @map = new google.maps.Map(@el, { center: @defaultCoords, zoom: 7, scrollwheel: false })

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((data) =>
        @map.setCenter(@_parsePosition(data))
      ), ->
        @_fetchIPLocation()
    else
      @_fetchIPLocation()

    @_drawMarkers(@authors)
    @markerCluster = new MarkerClusterer(@map, @markers, imagePath: @imagePath)

  _parsePosition: (data) ->
    {
      lat: data.coords.latitude
      lng: data.coords.longitude
    }

  _fetchIPLocation: ->
    $.get("/locations/fetch").done((data) ->
      @map.setCenter(@_parsePosition(data))
    ).fail ->
      console.error "Your location could not be fetched."

  _drawMarkers: (locations) ->
    locations.forEach (location, i) =>
      marker = new google.maps.Marker({ position: location, map: @map })
      @markers.push(marker)

      marker.addListener "click", ->
        @_closeInfoWindows()
        @_createInfoWindow(location.info).open(@map, marker)
        @map.panTo(marker.getPosition())

  _closeInfoWindows: ->
    @infoWindows.forEach (box, i) ->
      box.close()

  _createInfoWindow: (content) ->
    infoWindow = new google.maps.InfoWindow({ content: content })
    @infoWindows.push(infoWindow)
    infoWindow

  _redrawMarkers: (locations) ->
    @_deleteMarkers();
    @_drawMarkers(locations);

    @markerCluster.clearMarkers();
    @markerCluster.addMarkers(@markers);

  _deleteMarkers: ->
    @_clearMarkers()
    @_closeInfoWindows()
    @markers = []
    @infoWindows = []

  _clearMarkers: ->
    @markers.forEach (marker, i) ->
      marker.setMap(null)

  _search: (query) ->
    $.get("/authors/search", query: query).done((data) =>
      @_redrawMarkers(data.users)
    ).fail ->
      console.error "Search error."

  _bindFilter: ->
    @ui.$query.bind "typeahead:select", (e, suggestion) =>
      @_search(suggestion.title)

    @ui.$query.bind "typeahead:autocomplete", (e, suggestion) =>
      @_search(suggestion.title)
      @ui.$query.typeahead "close"

    @ui.$query.on "input", (e) =>
      if !e.target.value.length
        @_search("")

gmap = new App.Components.Gmap(document.getElementById("map"))


