module RoundedCornersHelper
  def rounded_corners(color_class='gray', options={}, &block)
    content = capture(&block)
    rounded_content = render_rounded_corners(content, color_class, options)
    concat(rounded_content)
    concat(spacer)
  end

  def render_rounded_corners(content, color_class='gray', options={})
    options[:extra_class]||='margined-bottom'

    html = %{
      <div class='#{options[:extra_class]}' id='#{options[:id]}' style='#{options[:style]}'>
    }

    unless options[:no_top]
      html << %{
        <b class="b1f #{color_class}"></b><b class="b2f #{color_class}"></b><b class="b3f #{color_class}"></b><b class="b4f #{color_class}"></b>
      }
    end

    html << %{
      <div class="contentf #{color_class}">
          <div class='inner_contentf'>
          #{content}
          </div>
          <div class='clear'></div>
      </div>
      <b class="b4f #{color_class}"></b><b class="b3f #{color_class}"></b><b class="b2f #{color_class}"></b><b class="b1f #{color_class}"></b>
      </div>
    }

    html
  end
end
