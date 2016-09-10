class UsersController < ApplicationController
  expose(:users) { UsersByArticle.new(query).with_position }

  def search
    render json: users, each_serializer: AuthorSerializer
  end

  private

  def query
    params.permit(:query)[:query]
  end
end
