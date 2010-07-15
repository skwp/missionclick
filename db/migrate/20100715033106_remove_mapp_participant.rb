class RemoveMappParticipant < ActiveRecord::Migration
  def self.up
    drop_table :mapp_participants rescue ""
  end

  def self.down
  end
end
