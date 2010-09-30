class Festival < ActiveRecord::Base
  has_many :events
  has_many :festival_participants
  has_many :venues, :through => :festival_participants

  named_scope :current, :conditions => {:current => true}
  named_scope :mapp, :conditions => "short_name like 'mapp_%'", :order => 'created_at desc'
  named_scope :upcoming, :conditions => "start_time >= now()"
  named_scope :with_participating_venue, lambda {|venue| {:select => "festivals.*, fp.description as participant_description", :joins => "inner join festival_participants fp on fp.festival_id = festivals.id and fp.venue_id = #{venue.id}"}}

  validates_uniqueness_of :short_name

  def find_participant(venue)
    festival_participants.find_by_venue_id(venue.id)
  end

  def self.current_mapp
    self.current.mapp.first
  end

  def mapp?
    short_name =~ /^mapp_/
  end
end
