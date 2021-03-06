class VenuesController < ApplicationController
  skip_before_filter :show_beta_screen
  cache_sweeper :mapp_sweeper, :only => [:create, :update, :destroy]

  include EventsHelper

  # require_admin :except => [:index, :show]

  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    @venue = Venue.find(params[:id])
    @events = @venue.events.starting_today
    separate_events_by_date

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        flash[:notice] = 'Venue was successfully created.'
        format.html { redirect_to(@venue) }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])
    
    # TODO this should be handled on create as well
    @festivals = params[:festivals]
    @festivals && @festivals.keys.each do |festival_id|
      logger.info "Processing festival id: #{festival_id}; FestivalParticipant.find_by_festival_id_and_venue_id(#{festival_id}, #{@venue.id}) "
      if participant = FestivalParticipant.find_by_festival_id_and_venue_id(festival_id, @venue.id)
        participant.update_attribute(:description, @festivals[festival_id][:participant_description])
      end
    end

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        flash[:notice] = 'Venue was successfully updated.'
        format.html { redirect_to(@venue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
end
