App.Components ||= {}

class App.Components.Markers
  IMAGE_PATH = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m"

  constructor: (@map) ->
    @_bindUI()
    @_bindEvents()

    @markers = []
    @infoWindows = []

    @_drawMarkers(App.authors)
    @markerCluster = new MarkerClusterer(@map, @markers, imagePath: IMAGE_PATH)

  _bindUI: ->
    @ui =
      $query: $(".js-autocomplete")

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

  gmap = (new App.Components.Gmap()).draw()
  markers = new App.Components.Markers(gmap)
