# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#

venues_direct = [

  Venue.create(
    :name => "Revolution Cafe", 
    :url => "http://myspace.com/revcafe2006",  
    :address => "3248 22nd St.", :city => "San Francisco", :state => "CA", :zip => "94110", 
    :ical_feed_url => "http://www.google.com/calendar/ical/4qam77hab6mmlkhq0ijim94vf0%40group.calendar.google.com/public/basic.ics",
    :twitter_username => "TheRevCafe",
    :facebook_fan_page => "http://www.facebook.com/pages/San-Francisco-CA/The-Revolution-Cafe/398859449697"
  ),

  Venue.create(
    :name => "Kaleidoscope Free Speech Zone", 
    :url => "http://kaleidoscopefreespeechzone.com/", 
    :address => "3109 24th St.", :city => "San Francisco", 
    :state => "CA", 
    :zip => "94110", 
    :ical_feed_url => "http://www.google.com/calendar/ical/kaleidoscopesf%40gmail.com/public/basic.ics",
    :twitter_username => "kaleidoscopesf",
    :facebook_fan_page => "http://www.facebook.com/pages/San-Francisco-CA/kaleidoscope/99142838231"
  ),

  Venue.create(
    :name => "Million Fishes Art Collective",
    :url => "http://millionfishes.com/",
    :address => "2501 Bryant St.", :city => "San Francisco",
    :state => "CA", :zip => "94110",
    :ical_feed_url => "http://www.google.com/calendar/ical/7sd5kfg76rmcph89i838itv94k%40group.calendar.google.com/public/basic.ics",
    :summary => "Million Fishes is an incubating program for emerging artists of visual art, film making, choreography / dance, music, conceptual art, new media, interactive art, interarts, and writing to build the tools necessary to establish themselves as contributors of art."
  ),

# Their feed has all kinds of errors and one of their events causes our ical processor to hang 
#  Venue.create(:name => "The Lab", 
#  :address => "2948 16th St.", 
#  :url => "http://thelab.org",
#  :city => "San Francisco", 
#  :state => "CA", :zip => "94103", 
#  :ical_feed_url => "http://www.thelab.org/thyme/remote/ical.php/1/The%20LAB%20Events%20Calendar.ics",
#  :twitter_username => "_theLAB_")
]

venues_scraped = [
  Venue.create(
    :name => "Amnesia",
    :url => "http://www.amnesiathebar.com/",
    :address => "853 Valencia St.", :city => "San Francisco",
    :state => "CA", :zip => "94110",
    :ical_feed_url => "http://gopher.missionclick.com/scrape/amnesia/"
  )
]

puts "Populating database with feeds. If you have no internets, this will hang! (hit ctrl-c)"
# (venues_direct + venues_scraped).each {|venue| venue.fetch_events }
venues_scraped.each {|venue| venue.fetch_events }
