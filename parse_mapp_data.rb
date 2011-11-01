class MappParser
  def self.update_description(venue, venue_description)
    festival = Festival.current_mapp
    participant = festival.festival_participants.find_by_venue_id(venue.id) || festival.festival_participants.create(:venue_id => venue.id)
    puts "Updating participant #{participant.id} description #{venue_description}"
    participant.update_attribute(:description,  venue_description)
    festival
  end

  def self.parse_data(venue, venue_description, data=nil)
    festival = update_description(venue, venue_description)

    data && data.split("\n").each do |line|
      puts "Working line: #{line}"
      md = line.match(/(\d+\:\d+.*\d+\:\d+)(.*)/)
      next unless md
      times = md[1].gsub(" ", "").split("-").map {|t| "#{t}pm"}
      puts "Parsing times: #{times.inspect}"
      start, finish = parse_time(festival, times.first), parse_time(festival, times.last)
      if finish < start
        finish += 12.hours #it should be AM instead of pm
      end

      description = md[2].strip
      attrs = {:festival_id => festival.id, :start_time => start, :finish_time => finish, :title => description}
      puts "Creating: #{attrs.inspect}"
      venue.events.create!(attrs)
    end
    expire_cache
  end

  def self.parse_time(festival, time)
    date = festival.start_time.strftime("%b %d")
    DateTime.parse("#{date} #{time} #{DateTime.now.zone}")
  end

  def self.expire_cache
    %w(schedule now venues events starred).each do |grouping_type|
      %w(true false).each do |iphone_type|
        %w(true false).each do |editable_type| 
          ActionController::Base.new.expire_fragment "mapp/#{grouping_type}/#{iphone_type}/#{editable_type}"
        end
      end
    end
  end
end
  
venue = Venue.find_by_name("The Red Poppy Art House")
description =<<-EOF
Curator: Rafael Sarria	
Painting exhibition of Red Poppy visiting resident artist Herselia Cantoral. Exhibition of "Mission Mercy Jimenez Mural" by Evan Bissell". 
"Live Musica Latina" 
EOF

data = %{
8:00-8:45 Boca do Rio (Samba Rock) 
9:00-9:45 Johanna Suarez "iE iE" (Colombian Songstress and Dance) 
10:00-11:00 La Gente (Cumbia/Reggae/Salsa/Hip-Hop) 
11:15-12:00 BOMBA BOMBA. feat. Hector Lugo & Christina
}

MappParser.parse_data(venue, description, data)


venue = Venue["PATHOS on Harrison"]
description = <<-EOF
Curator: Jorge Molina and David Kubrin
Photography by Nichol Sepanek will be featured throughout the night
Wish tree by Anna Fizyta. Pecan Pies and Drinks by Jericho Lindsey
EOF
data = %{
8:00-8:30 Introduction by David Kubrin
8:30-8:50 Stina da Silva, Singer Songwriter
8:50-9:10 Alejandro Murguia, Poet
9:10-9:30 Colm O'Riain, Musician
9:30-9:50 David Kubrin, The Space of In-between
9:50-10:05 Nicole Baren, Poet
10:05-10:45 Classical Revolution
10:45-11:05 Ariel Eisen, Singer Songwriter
11:05-11:35 Alejandro Chavez
11:35-12:00 Jorge Molina with Spontaneous Combustion Opera with Guest Dancers
}
MappParser.parse_data(venue, description, data)

venue = Venue['Million Fishes Art Collective']
description =<<-EOF
Curator: Danielle Cohen and Rafael Sarria	
"Creatures" exhibition: A bestiary is a compendium of beasts - often illustrated volumes describing various animals, birds and even rocks. The natural history and illustration of each beast is usually accompanied by a fable, describing how every living thing has its own meaning or correlating story. This idea traditionally served as Christian allegory - for example, the pelican was believed to tear open its breast to bring its young to life with its own blood, which was seen as a living representation of Jesus. However; we are interested in your contemporary, fantastical interpretations of this idea.
EOF
data = %{
8:00-8:45 Euphorah (live multimedia electronic music and art) 
9:00-9:45 MWE 
10:00-11:00 Alma Desnuda
}
MappParser.parse_data(venue, description, data)

# 
venue = Venue['Area 2881']
description =<<-EOF 
Curator: Carl Pisaturo
An immersive Micromuseum of operating Lumino-Kinetic and Robotic Sculpture; 3D Photography; Structures and Curiosities of human and natural origin. 
EOF
data = %{ 8pm-12 Mariko MiyaKawa & Jeremy Reinhold (Jazz-esque electrified Cello & Keyboard) }
MappParser.parse_data(venue, description, data)

venue = Venue['Kaleidoscope Free Speech Zone']
description=nil
data = %{ 
9:00-12am "Late Night Breakfast" brings on an Americana folk show of music and storytelling. Visual Art by Trius Fernsler.
}
MappParser.parse_data(venue, description, data)

venue = Venue['La Victoria Bakery']
description = %{Curator: Jaime Maldonado	}
data = %{
3:00-10:00 Family Art (Childrens art exhibition) and LIVE MUSIC
}
MappParser.parse_data(venue, description, data)


venue = Venue['The Tango Cabin']
description = %{Curator: Don Pribor}
data =%{
9:00-11:30 Live tango music in the cottage, tango dancers in the patio. Come dance, sing, play or just watch and listen. 
}
MappParser.parse_data(venue, description, data)

venue = Venue.create(:user_id => User.first.id, :name => "Ruth's Table", :address=>"580 Capp", :city => "San Francisco", :state => "CA")
description = <<-EOF
Curator: Lola Fraknoi	
EOF
data = %{
12:00-4:00 will feature Music, gallery exhibit by artists of SCRAP, art demonstrations and projects, silent auction 
12:00-2:00 Origami opening ceremony by District 9 Supervisor David Campos
2:00-3:00 Dance Generators performing a piece choreographed for this event
3:00-4:00 Ruth’s Table Tai Chi class demonstration
3:45-4:00 End of silent auction and raffle
}
MappParser.parse_data(venue, description, data)

venue = Venue["Jamie & Wendy's"]
description = "Curator: Jamie Doyle & Wendy Marlatt	"
data=%{
7:30-8:00 Lior Benhur (Hebrew Roots Soul) 
8:00-8:20 Rashani (World Fusion BellyDance) 
8:30-9:30 Ben Thompson (Electronic Disco Funk)
}
MappParser.parse_data(venue, description, data)

venue = Venue['The Blue House']
description = "Curator: Tony Bravo"
# presented by: Zombie Officiant/Makeup Artist Evan Kaminsky, Beauty and Grooming Guru, owner of Oui, Three Queens Productions (www.ouithreequeens.com), providing hair, makeup, skincare and wedding services. Cake Artists Steph Meier and Richard Celic of Heaven and Hell Cakes (www.heavenandhellcakes.com)
data = %{
7:15-8:00 Zombie Wedding
8:00-8:15 Dash Kamm, Poet
8:15-9:00 Songs and Poetry, Gil Rodriguez, poet, Roberto Havan, sax, Russell Brown, guitar
9:00-9:20 Tony Bravo, Horizontally Speaking and other forms of TMI
9:20-9:45 Adam Cornford, Poet
9:45-12 Jam, all welcome
}
MappParser.parse_data(venue, description, data)

venue = Venue['The Secret Garden']
description = "Curator: Brian Robledo"
data = %{
7:00-7:20 Exibition ¨Body maps¨ youth latino student union 
7:20-7:30 Ariel Soto (Photo) 
7:30-7:40 Mayra madriz (story telling) 
7:40-7:55 Mario Esteva (Music)
8:00-8:10 Natta (DANCE) 
8:10-8:20 Bryan Robledo (Hip Hop) 
8:20-8:35 Nancy steva (Singing and Poetry) 
8:35-8:55 Los Nadie (Music) 
}
MappParser.parse_data(venue, description, data)

venue = Venue.create(:user_id => User.first.id, :name => "Mission Cultural Center", :address=>"2868 Mission St.", :city => "San Francisco", :state => "CA")
description = "Curator: Iyara Robles<br/>Meet in front of Mission Cultural Center 10 to 15 minutes early to pick up your limited edition map/zine with program." 
# 1-2:30 PM with Trunk Show and Receptionn to follow in MCCLA Gallery until 5pm. Featuring  Isso SF, Marilyn Yu, Ector Garcia, Michelle Wolfie Rodriguez, Sy Wagone/C.I.C., Sisterz of the Underground, Soulful Dress, Leeann’sVintage/Static, Jeepneys, Zineblasters!, Jai Arun Ravine, Emael, Jukie Sunshine, Pippa Fleming, Golden Roots Catering"
data=%{
1:00-2:30 Fashion Crawl with Trunk Show
5-7 Reception in MCCLA Gallery
}
MappParser.parse_data(venue, description, data)
 
venue = Venue['Galeria de La Raza']
description = "Curator: Nairem Morales<br/>The Family Day, created in appreciation of Galería's cherished community, is intended to invite neighbors and new individuals to discover Galería's curriculum. The day will offer a fun and informative programming for all ages. Children will be able to participate in the hands-on-art-making activities with local artists and craftsmen. Guests will also experience a diverse sampling of the Galería's programs as well enjoy specialty music, art and performance." 
data=%{
6:00-6:40 Theresa Pérez
6:45-7:25 Cyborg Mutinity
7:30-8:10 Johana Suárez "iEiE"
8:15-9:00 Hector Lugo "Plenazo"
}
MappParser.parse_data(venue, description, data)

venue = Venue.create(:user_id => User.first.id, :name => "Mission Branch Library", :address=>"300 Bartlett", :address_hint => "24th west of Mission", :city => "San Francisco", :state => "CA")
description = "Curator: Johanna Suarez"
data = %{
1:00-2:30 Family Art face painting On The Second Floor 1-2pm Tambores de Colomia (Live Colombian music)
}
MappParser.parse_data(venue, description, data)


venue = Venue["L's cafe"]
description = "Curator: Martina Castro"
data = %{
7:00-7:30 Screening of "Waqaynan" 
7:30-8:00 Talk with director Ariel Soto 
8:00-8:30 Cascada De Flores (Traditional Musica Mexicana) 
8:40-9:10 Cyrus Ghazizadeh (Live Flamenco Fusion) 
9:20-9:50 Lior BenHur (Hebrew Roots Soul)
}
MappParser.parse_data(venue, description, data)

venue = Venue['Casa de los Sentidos']
description = <<-EOF
Curator: Luis Vasquez-Gomez<br/>	
Paintings by Maria Claudia Guerrero, Luis Vasquez-Gomez, Hersalia Cantoral, Yoly Herrera<br/>
Photography by Alejandro Meza
EOF
data = %{
7:45-8:30 Ceremony for the Ancestors
8:30-9:00 Miguel Robles, Poetry del Aqui y el Ahora 
9:00-9:30 "Maria Machetes", & border OUT lgbtq, immigrant collaborative traditional alternative music
9:30-10:00 Alfredo Gomez, Canta autor, Singing to Life 
10:00-10:30 MamaCoatl, Song writer, Songs of Resistance 
10:30-11:00 Rupa, Song writer, Songs for the next Millenium 
11:00-12:00 Candelaria Band, To dance for life -- Cumbia, reggae, and everything in between.
}
MappParser.parse_data(venue, description, data)

venue = Venue.create(:user_id => User.first.id, :name => "Precita Eyes", :address=>"2649 Folsom St.", :address_hint => "at 22nd", :city => "San Francisco", :state => "CA")
description = "Curator: Ariana Terrence"
data = %{
6:00-9:00 Patricia Rose Reflections and Refractions.A Select Restrospective from 1980 - 2010. Art exhibiton and reception.
}

MappParser.parse_data(venue, description, data)
