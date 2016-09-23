class PagesController < ApplicationController
  include GmapsLinks

  helper_method :authors

  expose(:articles) { Article.order_recent.limit(10).includes(:user) }

  def home
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
end
