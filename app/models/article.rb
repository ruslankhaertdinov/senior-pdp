require "elasticsearch/model"

class Article < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name [Rails.env, model_name.collection].join('_')

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
    end
  end

  belongs_to :user

  validates :user, :title, :body, presence: true

  scope :order_recent, -> { order("created_at DESC") }
end
