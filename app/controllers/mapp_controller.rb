class MappController < ApplicationController
  include EventsHelper
  skip_before_filter  :show_beta_screen
  before_filter :require_mapp_admin, :only => :bulk_edit

  def index
    params[:group] ||= 'now' #default
    
    @events = Festival.current_mapp.events
    @venues = @events.map(&:venue).uniq.sort_by(&:name)

    if params[:group] == 'now'
      @events = @events.starting_this_hour
    end

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

  # todo probably move this to events controller instead
  # bulk editing should be available on per-venue basis as well
  def bulk_edit
    if request.put?
      events = params[:venue][:events]
      events.each do |event_id, attributes|
        e = Event.find(event_id)
        logger.info "Found: #{e.inspect}"
        start_date = e.start_time.to_date
        finish_date = e.finish_time.to_date

        new_start_time = DateTime.parse("#{start_date} #{attributes['start_time(5i)']} #{e.start_time.zone}")
        new_finish_time = DateTime.parse("#{finish_date} #{attributes['finish_time(5i)']} #{e.finish_time.zone}")

        # support for events that end past midnight
        if new_finish_time < new_start_time
          new_finish_time += 1.day
        end

        e.title = attributes[:title]
        e.start_time = new_start_time
        e.finish_time = new_finish_time
        e.save

        logger.info "Saved: #{e.inspect}"
      end
    else
      @festival = Festival.current_mapp
      @events = Event.scoped(:include => :venue).by_festival_id(@festival.id).group_by{|e| e.venue}
    end
  end

end
