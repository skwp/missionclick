class HomeController < ApplicationController
  def index
    # TODO: this is pulling too much stuff right now
    @events = Event.all

    @today_events ||= []
    @tomorrow_events ||= []

    @events.each do |e|
      @today_events << @events.delete(e) if e.start_time.to_date == Date.today 
      @tomorrow_events << @events.delete(e) if e.start_time.to_date == Date.today.succ
    end
  end
end
