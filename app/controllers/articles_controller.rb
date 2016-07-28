class ArticlesController < ApplicationController
  expose(:articles) { Article.all }

  def index
    respond_with(articles)

    fresh_when(last_modified: articles.maximum(:updated_at))
  end
end
