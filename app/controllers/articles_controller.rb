class ArticlesController < ApplicationController
  respond_to :json

  expose(:articles) { Article.all }

  def index
    respond_with(articles)
  end
end
