module Account
  class ArticlesController < ApplicationController
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
        respond_with(article, location: account_article_url(article))
      else
        render :new
      end
    end

    def edit
    end

    def update
      if article.save
        respond_with(article, location: account_article_url(article))
      else
        render :edit
      end
    end

    def destroy
      article.destroy
      respond_with(article, location: account_articles_url)
    end

    private

    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
end
