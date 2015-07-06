class CreateMixes < ActiveRecord::Migration
  def change
    create_table :mixes do |t|
      t.text       :mixesdb_url
      t.text       :soundcloud_url
      t.text       :mixcloud_url
      t.text       :full_title
      t.text       :artists,       array: true, default: []
      t.text       :genres,        array: true, default: []
      t.text       :venue
      t.datetime   :air_date
      t.timestamps
    end
    add_index :mixes, :mixesdb_url, unique: true
    add_index :mixes, :artists, using: 'gin'
    add_index :mixes, :genres,  using: 'gin'
  end
end
