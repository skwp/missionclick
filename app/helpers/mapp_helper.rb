module MappHelper
  # Take a time like '5' and turn it into a datetime with the
  # proper date 
  def mapp_time(time)
    time = "#{@mapp_date} #{time} PM"
    DateTime.parse(time)
  end

  def mapp_nav
    sched_active = params[:group] == 'schedule' ? '_active' : ''
    hourly_active = params[:group] == 'hourly' ? '_active' : ''
    venues_active = params[:group] == 'venues' ? '_active' : ''

    "<div id='mapp_nav'>" +
    link_to(image_tag("mapp/schedule#{sched_active}.png"), :group => "schedule") + " " + 
    link_to(image_tag("mapp/venues#{venues_active}.png"), :group => 'venues')  + " " +
    link_to(image_tag("mapp/hourly#{hourly_active}.png"), :group => 'hourly') + "</div>"
  
  end
end
