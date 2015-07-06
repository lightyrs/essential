class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.text       :name,        null: false
      t.text       :mixesdb_url, null: false
      t.timestamps
    end
    add_index :venues, :mixesdb_url, unique: true
  end
end
