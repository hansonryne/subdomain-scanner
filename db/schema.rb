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

ActiveRecord::Schema.define(version: 2018_05_01_120027) do

  create_table "comparisons", force: :cascade do |t|
    t.integer "comparer_id"
    t.integer "compared_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compared_id"], name: "index_comparisons_on_compared_id"
    t.index ["comparer_id", "compared_id"], name: "index_comparisons_on_comparer_id_and_compared_id", unique: true
    t.index ["comparer_id"], name: "index_comparisons_on_comparer_id"
  end

  create_table "scans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "brute"
    t.integer "threads"
    t.string "phone_number"
  end

  create_table "subdomain_records", force: :cascade do |t|
    t.string "name"
    t.integer "scan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
