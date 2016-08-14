class AuthorArticlesController < ApplicationController
  before_action :authenticate_user!

  expose(:articles, ancestor: :current_user)
  expose(:article, attributes: :article_params)

  def index
  end

  def show
  end

  def new
  end

  def create
    if article.save
      redirect_to author_article_url(article), notice: "Article created successful!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if article.save
      redirect_to author_article_url(article), notice: "Article updated successful!"
    else
      render :edit
    end
  end

  def destroy
    article.destroy
    redirect_to author_articles_url, notice: "Article deleted successful!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
