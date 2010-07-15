class AddFestivalRefToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :festival_id, :integer
  end

  def self.down
  end
end
