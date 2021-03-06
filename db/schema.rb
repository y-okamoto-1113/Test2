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

ActiveRecord::Schema.define(version: 2019_03_18_022105) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "furigana"
    t.string "tel", null: false
    t.string "mail", null: false
    t.string "type_sex", null: false
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.string "type_career", null: false
    t.string "school_name"
    t.string "familyRelation", null: false
    t.string "familyRelationName", null: false
    t.string "familyRelation2"
    t.string "familyRelationName2"
    t.string "familyRelation3"
    t.string "familyRelationName3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "joined"
    t.string "position"
    t.string "joined_year"
    t.string "joined_month"
    t.string "joined_day"
    t.text "remarks"
  end

end
