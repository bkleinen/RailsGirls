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

ActiveRecord::Schema.define(version: 20131119135314) do

  create_table "fields", force: true do |t|
    t.string   "value"
    t.integer  "registration_id"
    t.integer  "metafield_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metafields", force: true do |t|
    t.string   "type"
    t.string   "values"
    t.string   "title"
    t.integer  "order"
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: true do |t|
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "workshops", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "description"
    t.text     "venue"
    t.integer  "participant_form_id"
    t.integer  "coach_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
