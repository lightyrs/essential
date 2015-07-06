class CreateEventsMixes < ActiveRecord::Migration
  def change
    create_table :events_mixes do |t|
      t.integer :event_id
      t.integer :mix_id
    end
    add_index :events_mixes, [:event_id, :mix_id], :unique => true
    add_index :events_mixes, :mix_id
  end
end
