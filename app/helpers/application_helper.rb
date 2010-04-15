# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def spacer; "<div class='spacer'></div>"; end
  def clear; "<div class='clear'></div>"; end

  def render_notices
    flash.map{ |name, msg|
      content_tag :div, msg, :class => 'flash',  :id => "flash_#{name}" if msg.is_a?(String)
    }.join
  end

  # For the main menu at the top
  def link_to_tab(text, link)
    content_tag :li, link_to(content_tag(:span,text),link), :id => ("current" if current_page?(link))
  end

  # A bit of custom code to make the link look like it belongs on our site
  def fb_sign_out_tab
    %{
      <form action="/users/sign_out" id="fb_connect_sign_out_form" method="get" style="display:none;"></form>
      <li><a href="#" onclick="FB.Connect.logoutAndRedirect('/users/sign_out')"><span>Sign out</span></a></li>
    }
  end

  # A convenient place to store icons, in case we want to globally switch them
  def user_icon(size=24); image_tag("handdrawn/#{size}x#{size}/user-man.png", :class => 'icon', :alt => 'user'); end
  def user_icon(size=24); image_tag("handdrawn/#{size}x#{size}/user-man.png", :class => 'icon'); end
end
