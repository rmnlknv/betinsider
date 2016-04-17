# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160417215614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "predictions", force: :cascade do |t|
    t.string   "discipline",                         default: ""
    t.string   "bettype",                            default: ""
    t.string   "info",                               default: ""
    t.datetime "date"
    t.decimal  "price",      precision: 8, scale: 2, default: 0.0, null: false
    t.string   "status",                             default: ""
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "predictions_users", id: false, force: :cascade do |t|
    t.integer "prediction_id"
    t.integer "user_id"
  end

  add_index "predictions_users", ["prediction_id", "user_id"], name: "index_predictions_users_on_prediction_id_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                          default: "",    null: false
    t.string   "encrypted_password",                             default: "",    null: false
    t.string   "name",                                           default: "",    null: false
    t.string   "surname",                                        default: "",    null: false
    t.decimal  "balance",                precision: 8, scale: 2, default: 0.0,   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.boolean  "is_admin",                                       default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
