class CreateGenresMixes < ActiveRecord::Migration
  def change
    create_table :genres_mixes do |t|
      t.integer :genre_id
      t.integer :mix_id
    end
    add_index :genres_mixes, [:genre_id, :mix_id], :unique => true
    add_index :genres_mixes, :mix_id
  end
end
