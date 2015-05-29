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

ActiveRecord::Schema.define(version: 20150529132231) do

  create_table "answers", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "upvotes",     limit: 4
    t.integer  "downvotes",   limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "answer_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "comments", ["answer_id"], name: "index_comments_on_answer_id", using: :btree
  add_index "comments", ["question_id"], name: "index_comments_on_question_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.string   "parent_url", limit: 255
    t.text     "content",    limit: 65535
    t.integer  "upvotes",    limit: 4
    t.integer  "downvotes",  limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.integer  "difference", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "questions_tags", id: false, force: :cascade do |t|
    t.integer "question_id", limit: 4
    t.integer "tag_id",      limit: 4
  end

  add_index "questions_tags", ["question_id", "tag_id"], name: "index_questions_tags_on_question_id_and_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "up_down_answers", force: :cascade do |t|
    t.integer  "answer_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "up",         limit: 1
    t.boolean  "down",       limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "up_down_answers", ["answer_id", "user_id"], name: "index_up_down_answers_on_answer_id_and_user_id", using: :btree

  create_table "up_downs", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.boolean  "up",          limit: 1
    t.boolean  "down",        limit: 1
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "up_downs", ["question_id", "user_id"], name: "index_up_downs_on_question_id_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
