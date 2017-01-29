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

ActiveRecord::Schema.define(version: 20170128152428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "date"
    t.string   "language"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "doc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "xml"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "nick_name",                              null: false
    t.string   "email_address",                          null: false
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "last_login"
    t.datetime "last_unsuccessful_login"
    t.integer  "unsuccessful_logins",     default: 0
    t.integer  "number_of_comments",      default: 0
    t.integer  "rights",                  default: 0
    t.boolean  "enabled",                 default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email_address"], name: "index_users_on_email_address", using: :btree
    t.index ["nick_name"], name: "index_users_on_nick_name", using: :btree
  end

end
