class Event < ActiveRecord::Base
  # Some iCal events are 'recurring' events and have complex and 
  # often infinite recurrance rules. When we populate our database, 
  # we will pull recurring events only for a particular time window.
  # This corresponds to how often we populate. Meaning, if we populate
  # every two days, then we need to grab 'recurring' event info for two
  # days ahead. If we go every day then we're only interested in the
  # current day's recurring events. So the time window specified
  # by the :overlapping parameter becomes [Date.today, Date.today + 1.day]
  RECURRING_EVENT_WINDOW = 2.weeks

  belongs_to :venue
  default_scope :order => 'start_time asc'

  def to_s; title; end
  def to_param; "#{id}-#{title.parameterize}"; end

  def self.populate_from_venue_feed(venue)
    feed = FeedCache.get_live_or_cached(venue)
    populate_from_ical_feed(feed, venue)
  end

  # TODO this should tie to the venue from which the feed came
  def self.populate_from_ical_feed(feed, venue=nil, user=nil)
    transaction do 
      calendar = RiCal.parse_string(feed).first

      calendar.events.each do |event|
        logger.debug "Processing #{event.uid} - #{event.summary}"
        begin
          if event.recurs?
            event.occurrences(:overlapping => [Date.today, Date.today + RECURRING_EVENT_WINDOW]).each do |e| 
              create_from_ical_event(e, venue, user)
            end
          else
            create_from_ical_event(event, venue, user)
          end
        rescue => e
          # TODO: we are getting lots of errors from some event feeds
          # like thelab.org. I think they messed up some recurrance rules
          # We should generate a full error report summary for each feed.
          logger.error e.message 
        end
      end
    end

    return true # avoid returning the heavy calendar object
  end

  def self.create_from_ical_event(event, venue=nil, user=nil)
    if event.start_time < Date.today
      logger.info "Skipping event because it occurs before today: #{event.start_time}"
      return
    end

    attrs = {:title => event.summary, 
      :description => event.description, 
      :start_time => event.start_time, 
      :finish_time => event.finish_time, 
      :location => event.location, 
      :uid => event.uid,
      :venue_id => (venue.id if venue), 
      :user_id => (user.id if user)} 
    
    event = Event.find_by_uid(event.uid) || Event.new
    event.attributes = attrs
    event.save
  end

end
