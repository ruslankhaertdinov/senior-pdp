class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, null: false, index: true
      t.datetime :active_until, null: false
      t.integer :author_id, null: false
      t.string :stripe_charge_id, null: false
      t.timestamps
    end
  end
end
