class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases, id: false do |t|
      t.integer :prediction_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
