# A convenient place to store icons, in case we want to globally switch them
# The only assumption made is that icons must be in folders by size (16x16, 24x24)
module IconsHelper
  ICON_SET = 'handdrawn' 

  def user_icon(size=24); icon_tag('user-man', size, 'user'); end
  def ical_icon(size=24); icon_tag('calendar', size, 'ical feed'); end
  def settings_icon(size=24); icon_tag('configuration', size, 'settings'); end
  def delete_icon(size=24); icon_tag('remove', size, 'remove'); end
  def tag_icon(size=24); icon_tag('tag', size, 'tag'); end

  def icon_tag(name, size=16, options={})
    image_tag(icon_src(name,size), options.merge(:class => "#{options[:class]} icon icon_#{size}"))
  end

  def icon_src(name, size=16)
    "#{ICON_SET}/#{size}x#{size}/#{name}.png"
  end

  def full_icon_src(name, size=16)
    "/images/#{icon_src(name,size)}"
  end
end
