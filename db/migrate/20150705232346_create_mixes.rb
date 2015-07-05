class CreateMixes < ActiveRecord::Migration
  def change
    create_table :mixes do |t|
      t.text       :mixesdb_url
      t.text       :soundcloud_url
      t.text       :full_title
      t.text       :artist_string
      t.text       :genre_string
      t.datetime   :air_date
      t.timestamps
    end
    add_index :mixes, :mixesdb_url, unique: true
  end
end
