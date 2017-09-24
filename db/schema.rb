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

ActiveRecord::Schema.define(version: 20170924012331) do

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "project_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "category_type"
    t.integer  "sub_resource_id"
    t.string   "sub_resource_type"
    t.integer  "action",            default: 0
    t.text     "resource_changes"
  end

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
    t.datetime "deleted_at"
  end

  add_index "todo_comments", ["deleted_at"], name: "index_todo_comments_on_deleted_at", using: :btree

  create_table "todo_lists", force: true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "todo_lists", ["deleted_at"], name: "index_todo_lists_on_deleted_at", using: :btree

  create_table "todos", force: true do |t|
    t.text     "title"
    t.integer  "project_id"
    t.integer  "todo_list_id"
    t.text     "brief"
    t.integer  "creator_id"
    t.integer  "assign_user_id"
    t.date     "expire_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",         default: 0
    t.datetime "deleted_at"
  end

  add_index "todos", ["deleted_at"], name: "index_todos_on_deleted_at", using: :btree

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
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
