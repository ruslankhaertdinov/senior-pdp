class PagesController < ApplicationController
  include GmapsLinks

  helper_method :locations

  expose(:articles) { Article.order_recent.limit(10) }

  def home
    fresh_when(articles + locations)
  end

  private

  def locations
    @locations ||=
      User.with_position.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          info: user.full_name
        }
      end
  end
end
