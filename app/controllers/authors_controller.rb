class AuthorsController < ApplicationController
  expose(:authors) { UsersByArticleContent.new(query_params[:query]).all }

  def search
  end

  private

  def query_params
    params.require(:query)
  end
end
