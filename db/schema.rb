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

ActiveRecord::Schema.define(version: 2019_09_29_150125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "title"
    t.string "email"
    t.string "password"
    t.text "bid_content"
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pid"
    t.integer "notifications", default: 0
    t.string "channel", default: "homeworkmarket"
    t.integer "last_calculated_page", default: 1
    t.index ["admin_user_id"], name: "index_accounts_on_admin_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.boolean "bid"
    t.float "price"
    t.string "link"
    t.string "slug"
    t.string "field"
    t.boolean "bid_accepted"
    t.float "accepted_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.float "developer_price"
    t.datetime "due_date"
    t.bigint "developer_id"
    t.index ["account_id"], name: "index_assignments_on_account_id"
    t.index ["developer_id"], name: "index_assignments_on_developer_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "full_name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filters", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "filter_type", default: 0
    t.integer "condition", default: 0
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_filters_on_account_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "processed_at"
    t.string "payment_id"
    t.string "reference_link"
    t.string "event"
    t.float "amount"
    t.float "change"
    t.float "balance"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "string_time_key"
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  add_foreign_key "accounts", "admin_users", on_delete: :cascade
  add_foreign_key "assignments", "accounts", on_delete: :cascade
  add_foreign_key "assignments", "developers"
  add_foreign_key "filters", "accounts", on_delete: :cascade
  add_foreign_key "transactions", "accounts", on_delete: :cascade
end
