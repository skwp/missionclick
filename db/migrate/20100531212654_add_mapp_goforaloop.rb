class AddMappGoforaloop < ActiveRecord::Migration
  def self.up
    gfl = Venue.create( :name => "Goforaloop Gallery and Studios", :url => "http://www.goforaloop.com/", :address => "1458 San Bruno Ave", :city => "San Francisco", :state => "CA", :zip => "94110")

    gfl.events.create(
    :title => "Laughing on the Inside: An Evaluation of Iconic Digestion", :description => "Curators: Nate Smith & Caleb Sheridan. Performances by DJs Epcot, Doials and Swndl. Laughing on the Inside: An Evaluation of Iconic Digestion. Opening Reception: Sat. June 5th, 7 - 11 PM. Free & all ages",
    :start_time => DateTime.parse("Jun 5 2010 7pm"), :finish_time => DateTime.parse("Jun 5 2010 11pm"))
    
  end

  def self.down
  end
end
