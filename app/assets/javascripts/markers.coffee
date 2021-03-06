App.Components ||= {}

class App.Components.Markers
  IMAGE_PATH = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m"

  constructor: (@map) ->
    @_bindEvents()

    @markers = []
    @infoWindows = []

    @_drawMarkers(App.authors)
    @markerCluster = new MarkerClusterer(@map, @markers, imagePath: IMAGE_PATH)

  _bindEvents: ->
    $(document).on "app:search_authors:done", @_redrawMarkers

  _drawMarkers: (locations) ->
    locations.forEach (location, i) =>
      marker = new google.maps.Marker({ position: location, map: @map })
      @markers.push(marker)

      marker.addListener "click", =>
        @_closeInfoWindows()
        @_createInfoWindow(location.info).open(@map, marker)
        @map.panTo(marker.getPosition())

  _createInfoWindow: (content) ->
    infoWindow = new google.maps.InfoWindow({ content: content })
    @infoWindows.push(infoWindow)
    infoWindow

  _redrawMarkers: (event, locations) =>
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
  mapEl = document.getElementById("map")

  if document.body.contains(mapEl)
    gmap = (new App.Components.Gmap(mapEl)).draw()
    markers = new App.Components.Markers(gmap)
