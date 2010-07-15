class MappController < ApplicationController
  include EventsHelper
  skip_before_filter  :show_beta_screen

  def index
    params[:group] ||= 'schedule' #default
    
    @events = Festival.current_mapp.events
    @venues = @events.map(&:venue).uniq

    if params[:group] == 'starred'
      @starred_events = Event.find((cookies[:stars] || "").split(","))
    end

    @show_time_only = true
    @show_full_description = true
    @hide_location_in_events = (params[:group] == 'venues')

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
