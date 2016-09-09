class AuthorsController < ApplicationController
  expose(:authors) { UsersByArticle.new(query).with_position }

  def search
    render json: authors, each_serializer: AuthorSerializer
  end

  private

  def query
    params.permit(:query)[:query]
  end
end
