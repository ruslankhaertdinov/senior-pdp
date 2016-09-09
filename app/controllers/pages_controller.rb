class PagesController < ApplicationController
  include GmapsLinks

  helper_method :authors

  expose(:articles) { Article.order_recent.limit(10).includes(:user) }

  def home
    fresh_when(last_modified: last_modified)
  end

  private

  def authors
    users_with_position.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info: view_context.link_to(user.full_name, user_articles_path(user_id: user), target: :blank)
      }
    end
  end

  def users_with_position
    @users_with_position ||= User.with_position
  end

  def last_modified
    [
      articles.maximum(:updated_at),
      users_with_position.maximum(:updated_at)
    ].max
  end
end
