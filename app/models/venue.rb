class Venue < ActiveRecord::Base
  acts_as_mappable
  before_validation_on_create :geocode_address

  has_many :events

  default_scope :order => 'name asc'

  def to_s; name; end
  def to_param; "#{id}-#{name.parameterize}"; end

  def self.[](name)
    find_by_name(name)
  end
  
  def fetch_events
    RAILS_DEFAULT_LOGGER.info "Parsing venue feed: #{self}"
    Event.populate_from_venue_feed(self)
  rescue
    RAILS_DEFAULT_LOGGER.error "Error parsing feed from venue #{self}: #{$!.message}"
  end

  def facebook_page_id
    URI.parse(facebook_fan_page).path.split("/").last
  end

  def address_with_hint
    address + (address_hint ? " #{address_hint}" : "")
  end

  def full_address
    "#{address} #{city}, #{state} #{zip}"
  end

  private
  
  def geocode_address
    geo = Geokit::Geocoders::MultiGeocoder.geocode("#{address} #{city}, #{state} #{zip}") 
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end
