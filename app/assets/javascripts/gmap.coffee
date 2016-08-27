App.Components ||= {}

class App.Components.Gmap
  constructor: (@el) ->
    @_initDefaultVars()
    @_bindUI()
    @_bindEvents()
    @_initMap()

  _initDefaultVars: ->
    @defaultCoords = { lat: 37.773972, lng: -122.431297 }
    @markers = []
    @infoWindows = []
    @imagePath = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m"
    @authors = App.authors

  _bindUI: ->
    @ui =
      map: document.getElementById("map") # map not rendered if use `$("#map")`
      $query: $("#query")

  _bindEvents: ->
    @ui.$query.on "typeahead:select", @_searchSelection
    @ui.$query.on "typeahead:autocomplete", @_searchAutocomplete
    @ui.$query.on "input", @_performBlankSearch

  _searchSelection: (event, suggestion) =>
    @_search(suggestion.title)

  _searchAutocomplete: (event, suggestion) =>
    @_search(suggestion.title)
    @ui.$query.typeahead("close")

  _performBlankSearch: (event) =>
    if !event.target.value.length
      @_search("")

  _search: (query) ->
    $.get("/authors/search", query: query).done((data) =>
      @_redrawMarkers(data.users)
    ).fail ->
      console.error "Search error."

  _initMap: ->
    @map = new google.maps.Map(@ui.map, { center: @defaultCoords, zoom: 7, scrollwheel: false })

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((data) =>
        @map.setCenter(@_parsePosition(data))
      ), =>
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
    $.get("/locations/fetch").done((data) =>
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

  _createInfoWindow: (content) ->
    infoWindow = new google.maps.InfoWindow({ content: content })
    @infoWindows.push(infoWindow)
    infoWindow

  _redrawMarkers: (locations) ->
    @_deleteMarkers()
    @_drawMarkers(locations)

    @markerCluster.clearMarkers()
    @markerCluster.addMarkers(@markers)

  _deleteMarkers: ->
    @_clearMarkers()
    @_closeInfoWindows()
    @markers = []
    @infoWindows = []

  _clearMarkers: ->
    @markers.forEach (marker, i) ->
      marker.setMap(null)

  _closeInfoWindows: ->
    @infoWindows.forEach (box, i) ->
      box.close()

$(document).ready ->
  return if !$("#map").length

  gmap = new App.Components.Gmap()


