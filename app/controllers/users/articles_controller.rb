module Users
  class ArticlesController < ApplicationController
    before_action :authenticate_user!

    expose(:user)
    expose(:articles, ancestor: :user)
    expose(:article)

    def index
    end

    def show
    end
  end
end
