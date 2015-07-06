class CreateMixes < ActiveRecord::Migration
  def change
    create_table :mixes do |t|
      t.text       :mixesdb_url, null: false
      t.text       :soundcloud_url
      t.text       :mixcloud_url
      t.text       :youtube_url
      t.text       :hulkshare_url
      t.text       :zippyshare_url
      t.text       :hearthisat_url
      t.text       :playfm_url
      t.text       :full_title, null: false
      t.references :artists, index: true
      t.references :genres, index: true
      t.references :events, index: true
      t.references :venues, index: true
      t.datetime   :air_date
      t.timestamps
    end
    add_index :mixes, :mixesdb_url, unique: true
  end
end
