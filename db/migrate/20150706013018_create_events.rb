class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text       :name,        null: false
      t.text       :mixesdb_url, null: false
      t.timestamps
    end
    add_index :events, :mixesdb_url, unique: true
  end
end
