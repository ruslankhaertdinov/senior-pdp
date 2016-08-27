App.Components ||= {}

class App.Components.Gmap
  DEFAULT_COORDS = { lat: 37.773972, lng: -122.431297 }

  constructor: ->
    @_bindUI()

  _bindUI: ->
    @ui =
      map: document.getElementById("map") # map not rendered if use `$("#map")`

  draw: ->
    map = new google.maps.Map(@ui.map, { center: DEFAULT_COORDS, zoom: 7, scrollwheel: false })

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((data) =>
        map.setCenter(@_parsePosition(data))
      ), =>
        @_fetchIPLocation(map)
    else
      @_fetchIPLocation(map)

    map

  _parsePosition: (data) ->
    {
      lat: data.coords.latitude
      lng: data.coords.longitude
    }

  _fetchIPLocation: (map) ->
    $.get("/locations/fetch").done((data) =>
      map.setCenter(@_parsePosition(data))
    ).fail ->
      console.error "Your location could not be fetched."
