class HomeController < ApplicationController
  include EventsHelper

  def index
    # TODO: this is pulling too much stuff right now
    @events = Event.all
    separate_events_by_date
  end
end
