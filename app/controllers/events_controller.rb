class EventsController < ApplicationController
  include EventsHelper
  
  cache_sweeper :mapp_sweeper, :only => [:create, :update, :destroy]

  def toggle_star
    params[:id] = params[:id].to_i
    star_list = (cookies[:stars] || "").split(",")

    respond_to do |format|
      format.js { 
        render :update do |page|
          logger.info "HERE IS THE COOKIE JAR #{star_list.inspect}"
          if star_list.include?(params[:id].to_s)
            star_list.delete(params[:id].to_s)
            page["star_#{params[:id]}"].src = full_icon_src("star",24)
            logger.info "Unstarred: #{params[:id]}"
          else
            star_list << params[:id].to_s
            page["star_#{params[:id]}"].src = full_icon_src("star_yellow",24)
            logger.info "Starred: #{params[:id]}"
          end

          cookies[:stars] = star_list.join(",")
        end
      }
    end
  end

  # GET /events
  # GET /events.xml
  def index
    @events = Event.scoped(:include => [:venue, :tags]).by_venue_id(params[:venue_id])
    @events = @events.send(:tagged_with, params[:tag]) if params[:tag]

    debugger
    respond_to_event_list
  end

  # GET /events/starred
  def starred
     @events = Event.find((cookies[:stars] || "").split(","))
     respond_to_event_list
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.venue_id ||= params[:venue_id].to_i

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.finish_time = nil if params[:no_finish_time]
    @event.festival = Festival.current_mapp if session[:mapp_admin] && Festival.current_mapp

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    @event.attributes = params[:event] 
    @event.finish_time = nil if params[:no_finish_time]
    @event.festival = Festival.current_mapp if session[:mapp_admin] && Festival.current_mapp

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(mapp_url) }
      format.xml  { head :ok }
    end
  end

  private
  def respond_to_event_list
    separate_events_by_date
    js_hash = lambda { {:today => @today_events, :tomorrow => @tomorrow_events, :later => @later_events }.to_json }

    respond_to do |format|
      format.html
      format.xml  { render :xml => @events }
      format.json { render :json => js_hash.call }
      format.js { render :text => "var events = #{js_hash.call}" }
    end
  end
end
