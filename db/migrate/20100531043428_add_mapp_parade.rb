class AddMappParade < ActiveRecord::Migration
  def self.up
    rp = Venue.find_by_name("The Red Poppy Art House")
    rp.events.create(:start_time => DateTime.parse("Jun 5, 2010 7:30pm"), :title => "The MAPP Street Music, Dance, Madness Parade", :description=>"Beginning at The Red Poppy Art House at 7:30 will be an open jam session that will then travel around the mission from venue to venue, creating chaos, lunacy and belligerancy.  Open to anyone who wants to play sing dance or just be strange.")
  end

  def self.down
  end
end
