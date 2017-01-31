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

ActiveRecord::Schema.define(version: 20170128175604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "page_images", force: :cascade do |t|
    t.integer  "transcription_xml_id"
    t.integer  "transcription_json_paragraph_id"
    t.json     "image"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transcription_json_paragraphs", force: :cascade do |t|
    t.jsonb    "content"
    t.string   "title"
    t.string   "language"
    t.string   "date"
    t.integer  "transcription_xml_id"
    t.integer  "search_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "transcription_xmls", force: :cascade do |t|
    t.json     "xml"
    t.integer  "page_image_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "page_images", "transcription_json_paragraphs", on_delete: :cascade
  add_foreign_key "page_images", "transcription_xmls", on_delete: :cascade
  add_foreign_key "transcription_json_paragraphs", "searches", on_delete: :cascade
  add_foreign_key "transcription_json_paragraphs", "transcription_xmls", on_delete: :cascade
  add_foreign_key "transcription_xmls", "page_images", on_delete: :cascade
end
