# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100420055531) do

  create_table "admins", :force => true do |t|
    t.string   "email",                            :null => false
    t.string   "encrypted_password", :limit => 40, :null => false
    t.string   "password_salt",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "uid"
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.string   "location"
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "fb_profiles", :force => true do |t|
    t.string   "name"
    t.string   "current_location"
    t.string   "email_hashes"
    t.string   "first_name"
    t.string   "has_added_app"
    t.string   "hometown_location"
    t.string   "is_app_user"
    t.string   "last_name"
    t.string   "locale"
    t.string   "meeting_for"
    t.string   "meeting_sex"
    t.string   "pic"
    t.string   "pic_with_logo"
    t.string   "pic_big"
    t.string   "pic_big_with_logo"
    t.string   "pic_small"
    t.string   "pic_small_with_logo"
    t.string   "pic_square"
    t.string   "pic_square_with_logo"
    t.string   "political"
    t.string   "profile_update_time"
    t.string   "profile_url"
    t.string   "proxied_email"
    t.string   "relationship_status"
    t.string   "religion"
    t.string   "sex"
    t.string   "significant_other_id"
    t.string   "timezone"
    t.text     "about_me"
    t.text     "books"
    t.text     "activities"
    t.text     "affiliations"
    t.text     "interests"
    t.text     "movies"
    t.text     "music"
    t.text     "quotes"
    t.text     "status"
    t.text     "tv"
    t.datetime "birthday"
    t.integer  "user_id"
  end

  add_index "fb_profiles", ["user_id"], :name => "index_fb_profiles_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                  :null => false
    t.string   "encrypted_password",   :limit => 40,                     :null => false
    t.string   "password_salt",                                          :null => false
    t.string   "confirmation_token",   :limit => 20
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token", :limit => 20
    t.string   "remember_token",       :limit => 20
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token",         :limit => 20
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facebook_uid",         :limit => 8
    t.string   "facebook_session_key", :limit => 149
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["facebook_session_key"], :name => "index_users_on_facebook_session_key"
  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "url"
    t.string   "ical_feed_url"
    t.string   "twitter_username"
    t.string   "facebook_fan_page"
    t.text     "summary"
    t.text     "homepage_html"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["user_id"], :name => "index_venues_on_user_id"

end
