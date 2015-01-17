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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150117201530) do
=======
ActiveRecord::Schema.define(version: 20150117192716) do
>>>>>>> 47eb6f6baf346282a420461997b44df672d4b7c6

  create_table "books", force: true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "edition"
    t.integer  "state"
    t.string   "email"
    t.string   "contact_name"
    t.string   "validation_code"
    t.string   "contact_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.float    "price"
    t.boolean  "activated"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "books", ["course_id"], name: "index_books_on_course_id"

  create_table "courses", force: true do |t|
    t.string   "acronym"
    t.string   "name"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["program_id"], name: "index_courses_on_program_id"

  create_table "programs", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "acronym"
  end

end
