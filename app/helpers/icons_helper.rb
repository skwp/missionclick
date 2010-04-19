module IconsHelper
  # A convenient place to store icons, in case we want to globally switch them
  def user_icon(size=24); image_tag("handdrawn/#{size}x#{size}/user-man.png", :class => 'icon', :alt => 'user'); end
  def ical_icon(size=24); image_tag("handdrawn/#{size}x#{size}/calendar.png", :class => 'icon', :alt => 'ical feed'); end
end
