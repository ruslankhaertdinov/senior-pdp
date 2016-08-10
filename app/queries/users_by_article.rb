class UsersByArticle
  attr_reader :query
  private :query

  delegate :with_position, to: :all

  def initialize(query)
    @query = query
  end

  def all
    return User.all if normalized_query.blank?

    User.joins(:articles).where("articles.id IN (?)", articles.ids).uniq
  end

  private

  def normalized_query
    query.strip
  end

  def articles
    Article.search(query).records.records
  end
end
