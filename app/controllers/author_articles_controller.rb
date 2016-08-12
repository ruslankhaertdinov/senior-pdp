class AuthorArticlesController < ApplicationController
  before_action :authenticate_user!

  expose(:articles, ancestor: :current_user)
  expose(:article)

  def index
  end
end
