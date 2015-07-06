class CreateArtistsMixes < ActiveRecord::Migration
  def change
    create_table :artists_mixes do |t|
      t.integer :artist_id
      t.integer :mix_id
    end
    add_index :artists_mixes, [:artist_id, :mix_id], :unique => true
    add_index :artists_mixes, :mix_id
  end
end
