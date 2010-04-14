class AddFacebookFields < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_uid, :integer, :limit => 8
    add_column :users, :facebook_session_key, :string, :limit => 149
    add_index :users, :facebook_uid
    add_index :users, :facebook_session_key
  end

  def self.down
  end
end
