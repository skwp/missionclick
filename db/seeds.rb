# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
Venue.create(:name => "Revolution Cafe", :address => "3248 22nd St.", :city => "San Francisco", :state => "CA", :zip => "94110", :ical_feed_url => "http://www.google.com/calendar/ical/4qam77hab6mmlkhq0ijim94vf0%40group.calendar.google.com/public/basic.ics")
