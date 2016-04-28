class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :subtype, null: false
      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
