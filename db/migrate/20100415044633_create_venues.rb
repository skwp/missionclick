class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :url
      t.string :ical_feed_url
      t.string :twitter_username
      t.string :facebook_fan_page
      t.text :summary
      t.text :homepage_html

      t.integer :user_id
      t.timestamps
    end

    add_index :venues, :user_id
  end

  def self.down
    drop_table :venues
  end
end
