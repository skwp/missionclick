module MappHelper

  def mapp_nav
    sched_active = params[:group] == 'schedule' ? '_active' : ''
    venues_active = params[:group] == 'venues' ? '_active' : ''
    starred_active = params[:group] == 'starred' ? '_active' : ''
    now_active = params[:group] == 'now' ? '_active' : ''

    "<div id='mapp_nav'>" +
    link_to(image_tag("mapp/now#{now_active}.png"), :group => "now") + " " + 
    link_to(image_tag("mapp/schedule#{sched_active}.png"), :group => "schedule") + " " + 
    link_to(image_tag("mapp/venues#{venues_active}.png"), :group => 'venues')  + " " +
    link_to(image_tag("mapp/starred#{starred_active}.png"), :group => 'starred') + "</div>"
  
  end
end
