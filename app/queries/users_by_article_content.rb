class UsersByArticleContent
  attr_reader :query
  private :query

  def initialize(query)
    @query = query
  end

  def all
    return User.all if query.blank?

    Rails.cache.fetch(query) do
      User.joins(:articles).where("articles.body ~* ?", query).uniq
    end
  end
end
