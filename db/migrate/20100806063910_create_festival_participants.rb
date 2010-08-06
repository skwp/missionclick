class CreateFestivalParticipants < ActiveRecord::Migration
  def self.up
    create_table :festival_participants do |t|
      t.text :description
      t.integer :festival_id
      t.integer :venue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :festival_participants
  end
end
