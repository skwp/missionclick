module EventsHelper
  def separate_events_by_date
    @today_events ||= []
    @tomorrow_events ||= []
    @later_events = []

    @events.each do |e|
      if e.start_time.to_date == Date.today 
        @today_events << e 
      elsif e.start_time.to_date == Date.today.succ
        @tomorrow_events << e
      else
        @later_events << e
      end
    end
  end

end
