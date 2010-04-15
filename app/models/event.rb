class Event < ActiveRecord::Base
  # Some iCal events are 'recurring' events and have complex and 
  # often infinite recurrance rules. When we populate our database, 
  # we will pull recurring events only for a particular time window.
  # This corresponds to how often we populate. Meaning, if we populate
  # every two days, then we need to grab 'recurring' event info for two
  # days ahead. If we go every day then we're only interested in the
  # current day's recurring events. So the time window specified
  # by the :overlapping parameter becomes [Date.today, Date.today + 1.day]
  RECURRING_EVENT_WINDOW = 1.day

  belongs_to :venue
  default_scope :order => 'start_time asc'

  def to_s; title; end
  def to_param; "#{id}-#{title.parameterize}"; end

  def self.populate_from_venue_feed(venue)
    # TODO: what if it's down, timing out, etc. deal with it...
    feed = open(venue.ical_feed_url).read
    populate_from_ical_feed(feed, venue)
  end

  # TODO this should tie to the venue from which the feed came
  def self.populate_from_ical_feed(feed, venue=nil, user=nil)
    transaction do 
      calendar = RiCal.parse_string(feed).first

      calendar.events.each do |event|
        if event.recurs?
          event.occurrences(:overlapping => [Date.today, Date.today + RECURRING_EVENT_WINDOW]).each do |e| 
            create_from_ical_event(e, venue, user)
          end
        else
          create_from_ical_event(event, venue, user)
        end
      end
    end
    true # avoid returning the calendar object
  end

  def self.create_from_ical_event(event, venue=nil, user=nil)
    if event.start_time < Date.today
      logger.info "Skipping event because it occurs before today: #{event.start_time}"
      return
    end

    create(:title => event.summary, 
      :description => event.description, 
      :start_time => event.start_time, 
      :finish_time => event.finish_time, 
      :location => event.location, 
      :uid => event.uid,
      :venue_id => (venue.id if venue), 
      :user_id => (user.id if user)) unless exists?(:uid => event.uid)
  end

end
