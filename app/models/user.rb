class User < ActiveRecord::Base
  # devise plugin handles authentication
  devise :facebook_connectable, :authenticatable, :recoverable,
  :rememberable, :registerable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation
  
  has_one :fb_profile
  has_many :venues
  has_many :events

  validates_presence_of :name

  acts_as_tagger

  def facebook_id; facebook_uid; end # facebooker compatibility

  def before_facebook_connect(fb_session)
    logger.info "BEFORE CONNECT"
    profile_fields = [:name, :birthday, :about_me, :activities, :affiliations, 
        :books, :current_location, :email_hashes, :first_name, :has_added_app, :hometown_location, 
        :interests, :is_app_user, :last_name, :locale, 
        :meeting_for, :meeting_sex, :movies, :music,
        :pic, :pic_with_logo, :pic_big, :pic_big_with_logo, :pic_small, 
        :pic_small_with_logo, :pic_square, :pic_square_with_logo, 
        :political, :profile_update_time, :profile_url, :proxied_email, 
        :quotes, :relationship_status, :religion, :sex, :significant_other_id, 
        :status, :timezone, :tv, ] 

    fb_session.user.populate(*profile_fields)
    
    field_values = profile_fields.reduce({}) do |hash, key|
      hash[key] = fb_session.user.send(key); hash
    end

    # special case field transformations
    field_values[:status] = field_values[:status].message 
    field_values[:hometown_location] = "#{field_values[:hometown_location].city}, #{field_values[:hometown_location].state}"
    field_values[:current_location] = "#{field_values[:current_location].city}, #{field_values[:current_location].state}"

    logger.info "populating profile with #{field_values.inspect}"

    self.build_fb_profile(field_values)
    self.name = field_values[:first_name]
  end

  def after_facebook_connect(fb_session)
  end

end
