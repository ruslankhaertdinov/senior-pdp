class UsersByArticle
  attr_reader :query
  private :query

  delegate :with_position, to: :all

  def initialize(query)
    @query = query
  end

  def all
    return User.all if query.blank?

    Rails.cache.fetch(query) do
      User.joins(:articles).where("articles.title ~* ?", normalized_query).uniq
    end
  end

  def normalized_query
    query.strip
  end
end
