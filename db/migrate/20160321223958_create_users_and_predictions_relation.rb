class CreateUsersAndPredictionsRelation < ActiveRecord::Migration
  def change
     create_table :predictions_users, id: false do |t|
      t.integer "prediction_id"
      t.integer "user_id"
    end
    add_index :predictions_users, ["prediction_id", "user_id"]
  end
end
