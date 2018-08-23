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

ActiveRecord::Schema.define(version: 20180524082451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "genre"
    t.string "publisher"
    t.integer "supplier_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.string "cover_file_name"
    t.string "cover_content_type"
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer "stock"
  end

  create_table "loan_lines", force: :cascade do |t|
    t.integer "loan_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_loan_lines_on_book_id"
    t.index ["loan_id"], name: "index_loan_lines_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.datetime "begin_date"
    t.datetime "end_date"
    t.boolean "returned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "status"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "stripe_id"
    t.string "nickname"
    t.decimal "display_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product"
    t.integer "book_limit"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "town"
    t.string "post_code"
    t.string "tel_no"
    t.string "email"
    t.string "password_digest"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "customer_id"
    t.bigint "plan_id"
    t.string "subscription_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["plan_id"], name: "index_users_on_plan_id"
  end

  add_foreign_key "loans", "users"
  add_foreign_key "users", "plans"
end
