class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :full_name, presence: true

  after_validation :geocode, if: :full_address_changed?

  geocoded_by :full_address

  scope :with_position, -> { where.not(latitude: nil, longitude: nil) }

  def full_address
    [country, city, address].select(&:present?).join(", ")
  end

  def subscribed_to?(author)
    subscriptions.active.where(author_id: author.id).any?
  end

  private

  def full_address_changed?
    (changed & %w(country city address)).any?
  end
end
