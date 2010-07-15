class RemoveMappParticipant < ActiveRecord::Migration
  def self.up
    drop_table :mapp_participants
  end

  def self.down
  end
end
