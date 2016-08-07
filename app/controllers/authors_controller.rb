class AuthorsController < ApplicationController
  expose(:authors) { UsersByArticle.new(query_params[:query]).with_position }
  expose(:author, model: User)
  expose(:articles, ancestor: :author)

  def search
    render json: authors, each_serializer: AuthorSerializer
  end

  def show
  end

  private

  def query_params
    params.permit(:query)
  end
end
