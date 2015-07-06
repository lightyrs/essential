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

ActiveRecord::Schema.define(version: 20150706015538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "mixesdb_url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["mixesdb_url"], name: "index_artists_on_mixesdb_url", unique: true, using: :btree

  create_table "artists_mixes", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "mix_id"
  end

  add_index "artists_mixes", ["artist_id", "mix_id"], name: "index_artists_mixes_on_artist_id_and_mix_id", unique: true, using: :btree
  add_index "artists_mixes", ["mix_id"], name: "index_artists_mixes_on_mix_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "mixesdb_url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["mixesdb_url"], name: "index_events_on_mixesdb_url", unique: true, using: :btree

  create_table "events_mixes", force: :cascade do |t|
    t.integer "event_id"
    t.integer "mix_id"
  end

  add_index "events_mixes", ["event_id", "mix_id"], name: "index_events_mixes_on_event_id_and_mix_id", unique: true, using: :btree
  add_index "events_mixes", ["mix_id"], name: "index_events_mixes_on_mix_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "mixesdb_url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["mixesdb_url"], name: "index_genres_on_mixesdb_url", unique: true, using: :btree

  create_table "genres_mixes", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "mix_id"
  end

  add_index "genres_mixes", ["genre_id", "mix_id"], name: "index_genres_mixes_on_genre_id_and_mix_id", unique: true, using: :btree
  add_index "genres_mixes", ["mix_id"], name: "index_genres_mixes_on_mix_id", using: :btree

  create_table "mixes", force: :cascade do |t|
    t.text     "mixesdb_url",    null: false
    t.text     "soundcloud_url"
    t.text     "mixcloud_url"
    t.text     "youtube_url"
    t.text     "hulkshare_url"
    t.text     "zippyshare_url"
    t.text     "hearthisat_url"
    t.text     "playfm_url"
    t.text     "full_title",     null: false
    t.datetime "air_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mixes", ["mixesdb_url"], name: "index_mixes_on_mixesdb_url", unique: true, using: :btree

  create_table "mixes_venues", force: :cascade do |t|
    t.integer "mix_id"
    t.integer "venue_id"
  end

  add_index "mixes_venues", ["mix_id", "venue_id"], name: "index_mixes_venues_on_mix_id_and_venue_id", unique: true, using: :btree
  add_index "mixes_venues", ["venue_id"], name: "index_mixes_venues_on_venue_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "mixesdb_url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["mixesdb_url"], name: "index_venues_on_mixesdb_url", unique: true, using: :btree

end
