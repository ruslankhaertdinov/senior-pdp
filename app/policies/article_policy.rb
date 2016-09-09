class ArticlePolicy < ApplicationPolicy
  def show?
    record.free? || user && user.subscribed_to?(record.user)
  end
end
