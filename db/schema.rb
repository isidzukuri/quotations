# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_16_102152) do

  create_table "authors", force: :cascade do |t|
    t.string "full_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_name"], name: "index_authors_on_full_name"
  end

  create_table "authors_books", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "book_id", null: false
    t.index "\"quotation_id\"", name: "index_authors_books_on_quotation_id"
    t.index ["book_id"], name: "index_authors_books_on_book_id"
  end

  create_table "authors_quotations", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "quotation_id", null: false
    t.index ["author_id"], name: "index_authors_quotations_on_author_id"
    t.index ["quotation_id"], name: "index_authors_quotations_on_quotation_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "credentials", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["email"], name: "index_credentials_on_email", unique: true
    t.index ["reset_password_token"], name: "index_credentials_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_credentials_on_user_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "language"
    t.integer "page"
    t.integer "percent"
    t.string "url"
    t.integer "user_id"
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_id"
    t.index ["book_id"], name: "index_quotations_on_book_id"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "scans", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "quotation_id"
    t.string "language"
    t.text "text"
    t.string "log"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.boolean "do_not_scan", default: false
    t.index ["quotation_id"], name: "index_scans_on_quotation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nick_name"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
