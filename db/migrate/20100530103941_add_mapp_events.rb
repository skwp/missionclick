class AddMappEvents < ActiveRecord::Migration
  def self.up
    area = Venue.create(
    :name => "Area 2881", 
    :url => "http://www.carlpisaturo.com/index.html",
    :address => "2881 23rd. St.", :city => "San Francisco", :state => "CA", :zip => "94110")

    area.events.create(:title => "Robotic Kinetic Light Sculpture", :description => "Robotic Kinetic Light Sculpture and 3D photographs of Carl Pisaturo", :start_time =>  jun5_time("8pm"), :finish_time => jun5_time("11pm"))

    MappParticipant.create(:venue => area, :mapp_name => "Jun 2010")

    tango = Venue.create(
      :name => "The Tango Cabin",
      :address => "111 York St.",
      :city => "San Francisco", :state => "CA", :zip => "94103")

    tango.events.create(:title => "Live tango, visual art, food", :description => "Live Tango Music, Tango dancers, visual artists, video projections and FOOD 9-11pm", :start_time => jun5_time("9pm"), :finish_time => jun5_time("11pm"))
    MappParticipant.create(:venue => tango, :mapp_name => "Jun 2010")
    
    esperanza = Venue.create(
      :name => "Esperanza Garden",
      :address => "Florida and 19th St.",:city => "San Francisco", :state => "CA", :zip => "94110")
    esperanza.events.create(:title => "A Music Flea Market", :start_time => jun5_time("12pm"), :finish_time => jun5_time("5pm"))
    MappParticipant.create(:venue => esperanza, :mapp_name => "Jun 2010")
    

    secret = Venue.create(
      :name => "The Secret Garden",
      :address => "Harrison and 23rd St.", :address_hint => "Between 23rd and 24th", :city => "San Francisco", :state => "CA", :zip => "94110")
    secret.events.create(:title => "live music, hip hop spoken word, story telling", :start_time => jun5_time("7pm"), :finish_time => jun5_time("10pm"))
    MappParticipant.create(:venue => secret, :mapp_name => "Jun 2010")
    

    sentidos = Venue.create(:name => "Casa de los Sentidos", :address => "2649 Folsom", :address_hint => "at 23rd", :city => "San Francisco", :state => "CA", :zip => "94110")
    sentidos.events.create(:title => "A Night of live music, Discussions, spoken word and Ceremony 7-11", :start_time => jun5_time("7pm"), :finish_time => jun5_time("11pm"))
    MappParticipant.create(:venue => sentidos, :mapp_name => "Jun 2010")
    

    cuentos = Venue.create(:name => "Casa Cuentos", :address => "1467 Florida", :city => "San Francisco", :state => "CA", :zip => "94110")
    cuentos.events.create(:title => "Storytelling in many mediums - sound, radio, print, musicians", :start_time => jun5_time("7pm"), :finish_time => jun5_time("10pm"), :description => "Sound Artists, Radio Producers, Print Journalists, Musicians, and visual artists coming together to create a celebration of storytelling in many mediums")
    MappParticipant.create(:venue => cuentos, :mapp_name => "Jun 2010")
    

    kaleidoscope = Venue.find_by_name("Kaleidoscope Free Speech Zone") 
    kaleidoscope.events.create(:title => %{Art by Jeremy Rourke, screening of an idependent film "Let Go" by Carolina Stankiewich paried with live music and dancers. Music by "Breakfast"}, :start_time => jun5_time("4pm"), :finish_time => jun5_time("9pm"))
    MappParticipant.create(:venue => kaleidoscope, :mapp_name => "Jun 2010")
    
    pathos = Venue.create(:name => "PATHOS on Harrison hosted by Jorge Molina", :address => "2754 Harrison", :city => "San Francisco", :state => "CA", :zip => "94110")
    pathos.events.create(:start_time => jun5_time("8pm"), :title => "Poetry - Helena Martinez")
    pathos.events.create(:start_time => jun5_time("8:30pm"), :title => "Singer Songwriter - Naima")
    pathos.events.create(:start_time => jun5_time("9:00pm"), :title => "Singer Songwriter - Joan Siquiero")
    pathos.events.create(:start_time => jun5_time("9:30pm"), :title => "Singer songwriter - Rebecca Cross")
    pathos.events.create(:start_time => jun5_time("9:45pm"), :title => "Poetry - Nicole Barons")
    pathos.events.create(:start_time => jun5_time("10:00pm"), :title => "Singer Songwriter - Alejandro Sanchez")
    pathos.events.create(:start_time => jun5_time("10:30pm"), :title => "Spontaneous Combustion, a collaboration of Madness")
    pathos.events.create(:start_time => jun5_time("11:15pm"), :title => "Tribal Blessings - Jeffery Alphonsus Mooney and crew")
    MappParticipant.create(:venue => pathos, :mapp_name => "Jun 2010")
    

    bluehouse = Venue.create(:name => "The Blue House", :address => "2548 Folsom", :city => "San Francisco", :state => "CA", :zip => "94110")
    bluehouse.events.create(:start_time => jun5_time("8pm"), :finish_time => jun5_time("11pm"), :title => "Jazz, poetry, visual art, live afro/latin/reggae/funk", :description => "Live Jazz music, visual art by Susan Joy Rippburger, Poetry by Adam cornford. Spoken word by Tony Bravo, and Live Afro/Latin/Reggae/Funk by Chocolate Jesus")
    MappParticipant.create(:venue => bluehouse, :mapp_name => "Jun 2010")
    

    box = Venue.create(:name => "The Box Factory", :address => "865 Florida", :address_hint => "at 21st", :city => "San Francisco", :state => "CA", :zip => "94110")
    box.events.create(:start_time  => jun5_time("7pm"), :title => "A fundraiser of Art Music and FOOD (all night)")
    MappParticipant.create(:venue => box, :mapp_name => "Jun 2010")
    

    rp = Venue.create(:name => "The Red Poppy Art House", :address => "2698 Folsom", :address_hint => "at 23rd", :city => "San Francisco", :state => "CA", :zip => "94110")
    rp.events.create(:title => "A full night of Art, discussions, and innovations", :start_time => jun5_time("6pm"), :finish_time => jun5_time("11pm"))
    MappParticipant.create(:venue => rp, :mapp_name => "Jun 2010")
    
  end

  private
  def self.jun5_time(time)
    DateTime.parse("2010-06-05 #{time}")
  end
end
