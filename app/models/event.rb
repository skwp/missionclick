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

  # TODO this should tie to the venue from which the feed came
  def self.populate_from_ical_feed(feed, user=nil)
    transaction do 
      calendar = RiCal.parse_string(feed).first

      calendar.events.each do |event|
        if event.recurs?
          event.occurrences(:overlapping => [Date.today, Date.today + RECURRING_EVENT_WINDOW]).each do |e| 
            create_from_ical_event(e)
          end
        else
          create_from_ical_event(event)
        end
      end
    end
    true # avoid returning the calendar object
  end

  def self.create_from_ical_event(event, user=nil)
    create(:title => event.summary, 
      :description => event.description, 
      :start_time => event.start_time, 
      :finish_time => event.finish_time, 
      :location => event.location, 
      :uid => event.uid,
      :user_id => (user.id if user)) unless exists?(:uid => event.uid)
  end

end
