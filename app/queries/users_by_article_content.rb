class UsersByArticleContent
  attr_reader :query
  private :query

  def initialize(query)
    @query = query
  end

  def all
    Rails.cache.fetch(query) do
      User.joins(:articles).where("articles.body ~* ?", query)
    end  
  end
end
