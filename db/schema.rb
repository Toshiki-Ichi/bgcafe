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

ActiveRecord::Schema[7.0].define(version: 2024_10_12_095502) do
  create_table "Groupschedules", charset: "utf8mb3", force: :cascade do |t|
    t.integer "day"
    t.string "group1_daytime"
    t.string "group2_daytime"
    t.string "group3_daytime"
    t.string "group1_20pm"
    t.string "group2_20pm"
    t.string "group3_20pm"
    t.string "group1_21pm"
    t.string "group2_21pm"
    t.string "group3_21pm"
    t.string "group1_22pm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group2_22pm"
    t.string "group3_22pm"
  end

  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "games", charset: "utf8mb3", force: :cascade do |t|
    t.string "game_name"
    t.text "rule"
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "require_time_id"
    t.integer "capacity_id"
    t.string "played"
    t.index ["room_id"], name: "index_games_on_room_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "ownplans", charset: "utf8mb3", force: :cascade do |t|
    t.date "target_week"
    t.string "day1"
    t.string "day2"
    t.string "day3"
    t.string "day4"
    t.string "day5"
    t.string "day6"
    t.string "day7"
    t.integer "frequency_id"
    t.integer "starter"
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_ownplans_on_room_id"
    t.index ["user_id"], name: "index_ownplans_on_user_id"
  end

  create_table "rooms", charset: "utf8mb3", force: :cascade do |t|
    t.string "room_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
    t.integer "creator_id"
  end

  create_table "schedule_data", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "groupschedule_id", null: false
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_schedule_data_on_game_id"
    t.index ["groupschedule_id"], name: "index_schedule_data_on_groupschedule_id"
    t.index ["room_id"], name: "index_schedule_data_on_room_id"
    t.index ["user_id"], name: "index_schedule_data_on_user_id"
  end

  create_table "user_rooms", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "career_id"
    t.string "likes"
    t.string "weakness"
    t.string "sns"
    t.text "note"
    t.integer "join1"
    t.integer "join2"
    t.integer "join3"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "games", "rooms"
  add_foreign_key "games", "users"
  add_foreign_key "ownplans", "rooms"
  add_foreign_key "ownplans", "users"
  add_foreign_key "schedule_data", "games"
  add_foreign_key "schedule_data", "groupschedules"
  add_foreign_key "schedule_data", "rooms"
  add_foreign_key "schedule_data", "users"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
