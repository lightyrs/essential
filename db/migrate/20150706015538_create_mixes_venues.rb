class CreateMixesVenues < ActiveRecord::Migration
  def change
    create_table :mixes_venues do |t|
      t.integer :mix_id
      t.integer :venue_id
    end
    add_index :mixes_venues, [:mix_id, :venue_id], :unique => true
    add_index :mixes_venues, :venue_id
  end
end
