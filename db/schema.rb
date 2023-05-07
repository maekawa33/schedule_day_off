# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_07_072411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "event_title"
    t.string "image"
    t.integer "price"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_events_on_schedule_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_favorites_on_schedule_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "schedule_title"
    t.integer "assumed_number_people"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "get_up_time", null: false
    t.time "sleep_time", null: false
    t.integer "favorites_count", default: 0, null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_taggings_on_schedule_id"
    t.index ["tag_id", "schedule_id"], name: "index_taggings_on_tag_id_and_schedule_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_tries_on_schedule_id"
    t.index ["user_id"], name: "index_tries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.string "avatar"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "login_type", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email", "login_type"], name: "index_users_on_email_and_login_type", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "schedules"
  add_foreign_key "favorites", "schedules"
  add_foreign_key "favorites", "users"
  add_foreign_key "schedules", "users"
  add_foreign_key "taggings", "schedules"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tries", "schedules"
  add_foreign_key "tries", "users"
end
