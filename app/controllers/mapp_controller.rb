class MappController < ApplicationController
  include EventsHelper
  skip_before_filter  :show_beta_screen

  def index
    params[:group] ||= 'schedule' #default
    @mapp_date = "Jun 5, 2010"
    @venues = MappParticipant.find_all_by_mapp_name("Jun 2010", :include => :venue).map(&:venue)
    @events = Event.scoped(:include => [:venue, :tags]).by_venues(@venues.map(&:id)).scoped(:conditions => ["start_time >= ? and (finish_time <= ? or finish_time is null)", DateTime.parse("Jun 5, 2010 10am PDT"), DateTime.parse("Jun 6, 2010 10am PDT")])
    @show_time_only = true
    @show_full_description = true
  end

end
