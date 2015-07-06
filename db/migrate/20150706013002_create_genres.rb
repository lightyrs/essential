class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.text       :name,        null: false
      t.text       :mixesdb_url, null: false
      t.timestamps
    end
    add_index :genres, :mixesdb_url, unique: true
  end
end
