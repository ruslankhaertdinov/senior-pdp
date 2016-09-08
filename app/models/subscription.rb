class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: User, foreign_key: :author_id

  validates :user, :stripe_charge_id, :author, :active_until, presence: true

  scope :active, -> { where("active_until > ?", Time.zone.now) }
end
