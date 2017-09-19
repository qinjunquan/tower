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

ActiveRecord::Schema.define(version: 20170919135123) do

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.text     "brief"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.string   "avator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todo_comments", force: true do |t|
    t.integer  "todo_id"
    t.integer  "creator_id"
    t.text     "content"
    t.text     "notice_user_ids"
    t.integer  "reply_user_id"
    t.integer  "like_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todo_lists", force: true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", force: true do |t|
    t.text     "title"
    t.integer  "project_id"
    t.integer  "todo_list_id"
    t.text     "brief"
    t.integer  "creator_id"
    t.integer  "assign_user_id"
    t.datetime "expire_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",         default: 0
  end

  create_table "user_project_ships", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "access",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_team_ships", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avator"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
