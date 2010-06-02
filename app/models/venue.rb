class Venue < ActiveRecord::Base
  acts_as_mappable
  before_validation_on_create :geocode_address

  has_many :events
  has_many :mapp_participants

  default_scope :order => 'name asc'

  def to_s; name; end
  def to_param; "#{id}-#{name.parameterize}"; end

  def fetch_events
    Event.populate_from_venue_feed(self)
  end

  def facebook_page_id
    URI.parse(facebook_fan_page).path.split("/").last
  end

  def address_with_hint
    address + (address_hint ? " #{address_hint}" : "")
  end

  private
  
  def geocode_address
    geo = Geokit::Geocoders::MultiGeocoder.geocode("#{address} #{city}, #{state} #{zip}") 
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end
