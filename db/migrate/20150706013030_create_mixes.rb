class CreateMixes < ActiveRecord::Migration
  def change
    create_table :mixes do |t|
      t.text       :mixesdb_url, null: false
      t.text       :soundcloud_urls, default: [], array: true
      t.text       :mixcloud_urls,   default: [], array: true
      t.text       :youtube_urls,    default: [], array: true
      t.text       :hulkshare_urls,  default: [], array: true
      t.text       :zippyshare_urls, default: [], array: true
      t.text       :hearthisat_urls, default: [], array: true
      t.text       :playfm_urls,     default: [], array: true
      t.text       :full_title, null: false
      t.datetime   :air_date
      t.timestamps
    end
    add_index :mixes, :mixesdb_url, unique: true
    add_index :mixes, :soundcloud_urls, using: 'gin'
    add_index :mixes, :mixcloud_urls, using: 'gin'
    add_index :mixes, :youtube_urls, using: 'gin'
    add_index :mixes, :hulkshare_urls, using: 'gin'
    add_index :mixes, :zippyshare_urls, using: 'gin'
    add_index :mixes, :hearthisat_urls, using: 'gin'
    add_index :mixes, :playfm_urls, using: 'gin'
  end
end
