class AuthorSerializer < ApplicationSerializer
  include ActionView::Helpers::UrlHelper

  delegate :url_helpers, to: "Rails.application.routes"

  attributes :lat, :lng, :info

  def lat
    object.latitude
  end

  def lng
    object.longitude
  end

  def info
    link_to object.full_name, url_helpers.author_path(object), target: :blank
  end
end
