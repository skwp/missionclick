# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#

revcafe = Venue.create(:name => "Revolution Cafe", :address => "3248 22nd St.", :city => "San Francisco", :state => "CA", :zip => "94110", :ical_feed_url => "http://www.google.com/calendar/ical/4qam77hab6mmlkhq0ijim94vf0%40group.calendar.google.com/public/basic.ics")
kalleidoscope = Venue.create(:name => "Kalleidoscope Free Speech Zone", :address => "3109 24th St.", :city => "San Francisco", :state => "CA", :zip => "94110", :ical_feed_url => "http://www.google.com/calendar/ical/kaleidoscopesf%40gmail.com/public/basic.ics")

# TODO/NOTE this makes a call to the internets. no connection = you will hang
puts "Populating database with feed from rev cafe. If you have no internet this will hang. See seeds.rb"
Event.populate_from_venue_feed(revcafe)
puts "Populating database with feed from kalleidoscope. If you have no internet this will hang. See seeds.rb"
Event.populate_from_venue_feed(kalleidoscope)
