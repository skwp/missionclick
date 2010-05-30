class CreateMappParticipants < ActiveRecord::Migration
  def self.up
    create_table :mapp_participants do |t|
      t.integer :venue_id
      t.string :mapp_name

      t.timestamps
    end
    add_column :venues, :address_hint, :string
  end

  def self.down
    drop_table :mapp_participants
  end
end
