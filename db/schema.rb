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

ActiveRecord::Schema.define(version: 2019_05_20_205603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_settings", force: :cascade do |t|
    t.float "price_multiplier", default: 1.0, null: false
    t.integer "easy_carousel_speed", default: 1, null: false
    t.integer "medium_carousel_speed", default: 2, null: false
    t.integer "hard_carousel_speed", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "easy_ticket_amount", default: 1, null: false
    t.integer "medium_ticket_amount", default: 2, null: false
    t.integer "hard_ticket_amount", default: 3, null: false
    t.boolean "game_blocked"
    t.text "fairness_text"
    t.text "terms_of_service"
  end

  create_table "purchase_options", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.integer "ticket_amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ticket_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "fullname"
    t.string "address"
    t.string "city"
    t.string "state_province_region"
    t.string "zipcode"
    t.string "clothing_size"
    t.string "shoe_size"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
    t.string "stripe_customer_id", default: ""
    t.integer "balance", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "ticket_transactions", "users"
end
