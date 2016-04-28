class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes, id: false do |t|
      t.integer :user_id
      t.integer :subscription_id

      t.timestamps null: false
    end
  end
end
