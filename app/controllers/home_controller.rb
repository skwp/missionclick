class HomeController < ApplicationController
  def index
    # TODO: we only want current day's events..this is for testing only
    @venue = Venue.first
    @events = @venue.events rescue []
  end
end
