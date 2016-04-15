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

ActiveRecord::Schema.define(version: 20160329194221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.string   "author",      default: "", null: false
    t.integer  "pages"
    t.integer  "year"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "attachment"
    t.string   "thumbnail"
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "books_categories", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  add_index "books_categories", ["book_id"], name: "index_books_categories_on_book_id", using: :btree
  add_index "books_categories", ["category_id"], name: "index_books_categories_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "title"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chapters", ["project_id"], name: "index_chapters_on_project_id", using: :btree
  add_index "chapters", ["user_id"], name: "index_chapters_on_user_id", using: :btree

  create_table "parts", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parts", ["chapter_id"], name: "index_parts_on_chapter_id", using: :btree
  add_index "parts", ["user_id"], name: "index_parts_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "public",      default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.integer  "sharee_id"
    t.integer  "document_id"
    t.string   "document_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "shares", ["document_type", "document_id"], name: "index_shares_on_document_type_and_document_id", using: :btree
  add_index "shares", ["user_id"], name: "index_shares_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
