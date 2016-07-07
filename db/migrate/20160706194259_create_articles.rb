class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, null: false, index: true
      t.string :title, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
