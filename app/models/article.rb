class Article < ActiveRecord::Base
  belongs_to :user

  validates :user, :title, :body, presence: true

  scope :order_recent, -> { order("created_at DESC") }
end
