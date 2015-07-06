class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.text       :name,        null: false
      t.text       :mixesdb_url, null: false
      t.timestamps
    end
    add_index :artists, :mixesdb_url, unique: true
  end
end
