module Users
  class ArticlesController < ApplicationController
    expose(:user)
    expose(:articles, ancestor: :user)
    expose(:article)

    def index
    end

    def show
    end
  end
end
