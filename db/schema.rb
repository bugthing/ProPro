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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121024210643) do

  create_table "charts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_group_id"
  end

  add_index "charts", ["user_group_id"], :name => "index_charts_on_user_group_id"

  create_table "section_lines", :force => true do |t|
    t.integer  "tool_id"
    t.integer  "section_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "section_lines", ["section_id"], :name => "index_section_lines_on_section_id"
  add_index "section_lines", ["tool_id"], :name => "index_section_lines_on_tool_id"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.integer  "chart_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sections", ["chart_id"], :name => "index_sections_on_chart_id"

  create_table "tools", :force => true do |t|
    t.string   "name"
    t.integer  "user_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "tools", ["user_group_id"], :name => "index_tools_on_user_group_id"

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_group_id"
  end

  add_index "users", ["user_group_id"], :name => "index_users_on_user_group_id"

end
