class HomeController < ApplicationController
  def index
    # TODO: we only want current day's events..this is for testing only
    @venues = Venue.all
    @events = Event.all
  end
end
