class AddFreeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :free, :boolean, default: true
  end
end
