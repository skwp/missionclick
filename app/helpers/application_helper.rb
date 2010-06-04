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

  def render_tags(tags)
      tags.map do |t|
        "<span class='tag'>#{link_to t, events_path(:tag => t.name)}</span>"
      end.join(", ")
    end

  def turn_off_top_featured_section
    content_for(:head) do 
      %{
      <style type="text/css" media="screen">
       #top_featured_section {display:none}
      </style>
      }
   end 
 end

 def fb_like_button_for_page(css_class='')
   %{
   <iframe class='#{css_class}' src="http://www.facebook.com/plugins/like.php?href=<%=CGI.escape(request.request_uri)%>&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=like&amp;font&amp;colorscheme=light&amp;height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:350px; display:block; margin: 10px auto 0 auto; height:80px;" allowTransparency="true"></iframe>
   } unless @iphone
  end

  def left_fb_like_button
    %{
    #{fb_like_button_for_page('left')}
    #{clear}
    } unless @iphone
  end

  def google_map_url(full_address)
    "http://maps.google.com?q=#{CGI.escape(full_address)}"
  end
end
