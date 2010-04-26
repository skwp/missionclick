class Venue < ActiveRecord::Base
  has_many :events

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
