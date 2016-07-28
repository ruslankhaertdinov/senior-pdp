class AuthorsController < ApplicationController
  expose(:authors) { UsersByArticleTitle.new(query_params[:query]).with_position }

  def search
    render json: authors, each_serializer: AuthorSerializer
  end

  private

  def query_params
    params.permit(:query)
  end
end
