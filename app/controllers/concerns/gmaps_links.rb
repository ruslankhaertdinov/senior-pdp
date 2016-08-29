module GmapsLinks
  extend ActiveSupport::Concern

  included do
    GMAPS_URL = "//maps.google.com/maps/api/js?v=3.24&key=#{ENV['GOOGLE_MAP_KEY']}"
    MARKER_CLUSTERER_URL = "//cdn.rawgit.com/googlemaps/js-marker-clusterer/gh-pages/src/markerclusterer.js"

    expose(:gmaps_url) { GMAPS_URL }
    expose(:marker_clusterer_url) { MARKER_CLUSTERER_URL }
  end
end
