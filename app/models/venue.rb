class Venue < ActiveRecord::Base
  has_many :events
  has_many :events_today, :class_name => "Event", :conditions => ["date(start_time) = date(now())"]
  has_many :events_tomorrow, :class_name => "Event", :conditions => ["date(start_time) = date(now() + '1 day')"]

  default_scope :order => 'name asc'

  def to_s; name; end
  def to_param; "#{id}-#{name.parameterize}"; end

  def fetch_events
    Event.populate_from_venue_feed(self)
  end

  def facebook_page_id
    URI.parse(facebook_fan_page).path.split("/").last
  end
end
