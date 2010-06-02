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
    @hide_location_in_events = (params[:group] == 'venues')

    @editable = true if session[:mapp_admin]

    js_hash = lambda { { :today => @events }.to_json }
    respond_to do |format|
      format.html
      format.js {
        resp = "var events = #{js_hash.call}" 
        cache_page(resp, "/mapp.js") # hacky but a temporary solution to cache only the js list
        render :text => resp
      }
    end
  end

end
