class CreateFestivals < ActiveRecord::Migration
  def self.up
    create_table :festivals do |t|
      t.string :name, :null => false
      t.datetime :start_time
      t.datetime :finish_time
      t.string :short_name
      t.boolean :current, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :festivals
  end
end
