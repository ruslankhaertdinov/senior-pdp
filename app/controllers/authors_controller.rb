class AuthorsController < ApplicationController
  expose(:authors) { UsersByArticleContent.new(query_params[:query]).all }

  def search
    render json: authors, each_serializer: AuthorSerializer
  end

  private

  def query_params
    params.permit(:query)
  end
end
