App.Components ||= {}

class App.Components.Gmap
  constructor: (@el) ->
    @_initDefaultVars()
    @_drawMap()

  _initDefaultVars: ->
    @defaultCoords = { lat: 37.773972, lng: -122.431297 }
    @markers = []
    @infoWindows = []
    @imagePath = "https://cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/images/m"
    @authors = App.authors

  _drawMap: ->
    @map = @_initMap()
    @_setCenter()
    @_drawMarkers(@authors)
    @_initMarkerCluster()

  _initMap: ->
    new google.maps.Map(@el, { center: @defaultCoords, zoom: 7, scrollwheel: false })

  _setCenter: () ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((data) =>
        @map.setCenter(@_parsePosition(data))
      ), ->
        @_fetchIPLocation()
    else
      @_fetchIPLocation()

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

  _initMarkerCluster: ->
    new MarkerClusterer(@map, @markers, imagePath: @imagePath)

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

gmap = new App.Components.Gmap(document.getElementById("map"))

