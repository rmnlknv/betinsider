class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.string :discipline, 	default: ""
      t.string :bettype, 			default: ""
      t.string :info, 			default: ""
      t.datetime   :date
      t.decimal :price,			precision: 8, scale: 2, default: 0.00, null: false
      t.string :status,			default: ""

      t.timestamps null: false
    end
  end
end
