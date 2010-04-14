class AddProfileFields < ActiveRecord::Migration
  def self.up
    string_profile_fields = [:name, :current_location, :email_hashes, :first_name, :has_added_app, :hometown_location, 
        :is_app_user, :last_name, :locale, :meeting_for, :meeting_sex,         
        :pic, :pic_with_logo, :pic_big, :pic_big_with_logo, :pic_small, 
        :pic_small_with_logo, :pic_square, :pic_square_with_logo, 
        :political, :profile_update_time, :profile_url, :proxied_email, 
        :relationship_status, :religion, :sex, :significant_other_id, 
        :timezone ] 
    
    text_profile_fields = [:about_me, :books, :activities, :affiliations,:interests, :movies, :music,:quotes,:status,:tv]

    create_table :fb_profiles do |t|
      string_profile_fields.each do |field|
        t.string field
      end

      text_profile_fields.each do |field|
        t.text field
      end

      t.datetime :birthday
    end

    add_column :fb_profiles, :user_id, :integer
    add_index(:fb_profiles, :user_id)
  end

  def self.down
    drop_table :fb_profiles
    remove_column :fb_profiles, :user_id
  end
end
