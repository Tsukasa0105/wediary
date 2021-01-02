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

ActiveRecord::Schema.define(version: 2020_12_27_005920) do

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "image"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "start_time"
    t.bigint "map_id"
    t.index ["group_id"], name: "index_events_on_group_id"
    t.index ["map_id"], name: "index_events_on_map_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "group_user_permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invited_user_id"
    t.bigint "inviting_group_id"
    t.index ["invited_user_id"], name: "index_group_user_permissions_on_invited_user_id"
    t.index ["inviting_group_id"], name: "index_group_user_permissions_on_inviting_group_id"
  end

  create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "key"
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "initial_pay_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "initial_user_id"
    t.bigint "pay_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initial_user_id"], name: "index_initial_pay_relationships_on_initial_user_id"
    t.index ["pay_record_id"], name: "index_initial_pay_relationships_on_pay_record_id"
  end

  create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "address"
    t.float "latitude"
    t.float "longitude"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_id"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_maps_on_user_id"
  end

  create_table "pay_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "paied_user_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_pay_records_on_event_id"
    t.index ["paied_user_id"], name: "index_pay_records_on_paied_user_id"
  end

  create_table "pay_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pay_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pay_record_id"], name: "index_pay_relationships_on_pay_record_id"
    t.index ["user_id"], name: "index_pay_relationships_on_user_id"
  end

  create_table "photos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.string "images"
    t.index ["event_id"], name: "index_photos_on_event_id"
    t.index ["group_id"], name: "index_photos_on_group_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  add_foreign_key "events", "groups"
  add_foreign_key "events", "maps"
  add_foreign_key "events", "users"
  add_foreign_key "group_user_permissions", "groups", column: "inviting_group_id"
  add_foreign_key "group_user_permissions", "users", column: "invited_user_id"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "initial_pay_relationships", "pay_records"
  add_foreign_key "initial_pay_relationships", "users", column: "initial_user_id"
  add_foreign_key "maps", "users"
  add_foreign_key "pay_records", "events"
  add_foreign_key "pay_records", "users", column: "paied_user_id"
  add_foreign_key "pay_relationships", "pay_records"
  add_foreign_key "pay_relationships", "users"
  add_foreign_key "photos", "events"
  add_foreign_key "photos", "groups"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
end
