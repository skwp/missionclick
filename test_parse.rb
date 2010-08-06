data = %{
7:30-8:00 Vanessa Valencia, singer
8:00-8:25 Adam Cornford, poet and novelist 
8:25-8:45 Theresa Dickinson, dancer and Alejandro Chavez, singer
8:45-9:10 Tony Bravo, vaudevillian- "Horizontally Speaking" 
9:10-9:30 Xavier Jurado, singer-songwriter
9:30-9:45 Dash Kamm, poet
9:45-10:00 Martina Castro, singer and Jesse Heurlin, guitarist - "Blue Heartbreak Covers"
}

venue = Venue.find_by_name("The Blue House")

data.split("\n").each do |line|
  md = line.match(/(\d+\:\d+.*\d+\:\d+)(.*)/)
  next unless md
  times = md[1].gsub(" ", "").split("-").map {|t| t =~ /pm/ ? t : "#{t}pm"}
  description = md[2].strip

  venue.events.create(:festival_id => 1, :start_time => "Aug 7 #{times.first} #{DateTime.now.zone}", :finish_time => "Aug 7 #{times.last} #{DateTime.now.zone}", :title => description)
end
