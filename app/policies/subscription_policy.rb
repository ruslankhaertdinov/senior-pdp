class SubscriptionPolicy
  attr_reader :user, :author
  private :user, :author

  def initialize(user, author)
    @user = user
    @author = author
  end

  def show?
    author.articles.premium.any? && user && !user.subscribed_to?(author)
  end
end
