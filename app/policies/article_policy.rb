class ArticlePolicy
  attr_reader :user, :article
  private :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def show?
    article.free? || user && user.subscribed?
  end
end
