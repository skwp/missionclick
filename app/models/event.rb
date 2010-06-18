class Event < ActiveRecord::Base

  acts_as_taggable

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
  default_scope :order => 'start_time asc', :include => :venue

  named_scope :today, :conditions => ["date(start_time) = date(now())"]
  named_scope :tomorrow, :conditions => ["date(start_time) = date(now() + '1 day')"]
  named_scope :by_venue_id, lambda {|venue_id| venue_id ? {:conditions => {:venue_id => venue_id.to_i}} :{}}
  named_scope :by_venues, lambda {|venues| {:conditions => {:venue_id => venues}}}

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
    logger.info "Processing start time: #{event.start_time}"
    if event.start_time < Date.today
      logger.info "Skipping event because it occurs before today: #{event.start_time}"
      return
    end

    attrs = {:title => event.summary, 
      :description => event.description, 
      :start_time => Time.new(event.start_time).getlocal, 
      :finish_time => event.finish_time, 
      :location => event.location, 
      :uid => event.uid,
      :venue_id => (venue.id if venue), 
      :user_id => (user.id if user)} 
    
    event = Event.find_by_uid(event.uid) || Event.new
    event.attributes = attrs
    event.save
  end

  # Determine if this event is going on at the specified DateTime
  def going_on_at?(time)
    # This method is a human convenience for determining what events are going 
    # on for example in the "7pm" time block. A human thinks of time in hour blocks
    # so an event happening at 7:30 or 7:45 is still within the 7pm block. Therefore
    # by subtracting 59 mins from the start time in the comparison below we can
    # group all events occuring at 7:something as a 7pm event
    time.between?(start_time - 59.minutes, finish_time || 100.years.from_now)
  end

  # Overriding standard method to include associations
  def to_json(*args)
    super(:include => [:venue, :tags])
  end

end
