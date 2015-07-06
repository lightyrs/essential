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

ActiveRecord::Schema.define(version: 20150705232346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mixes", force: :cascade do |t|
    t.text     "mixesdb_url"
    t.text     "soundcloud_url"
    t.text     "mixcloud_url"
    t.text     "youtube_url"
    t.text     "hulkshare_url"
    t.text     "zippyshare_url"
    t.text     "hearthisat_url"
    t.text     "full_title"
    t.text     "artists",        default: [], array: true
    t.text     "genres",         default: [], array: true
    t.text     "venue"
    t.datetime "air_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mixes", ["artists"], name: "index_mixes_on_artists", using: :gin
  add_index "mixes", ["genres"], name: "index_mixes_on_genres", using: :gin
  add_index "mixes", ["mixesdb_url"], name: "index_mixes_on_mixesdb_url", unique: true, using: :btree

end
