class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :uid
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :finish_time
      t.string :location 
      t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end

    add_index :events, :user_id
    add_index :events, :venue_id
    add_index :events, :uid
  end

  def self.down
    drop_table :events
  end
end
