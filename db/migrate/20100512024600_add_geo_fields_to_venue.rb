class AddGeoFieldsToVenue < ActiveRecord::Migration
  def self.up
    add_column :venues, :lat, :float, :size => 8
    add_column :venues, :lng, :float, :size => 8
    add_index :venues, :lat
    add_index :venues, :lng
  end
end
