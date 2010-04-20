# These block helpers help us create blocks of view that are visible
# only to the people in question. This prevents ugly conditional logic
# everywhere in the view.
# 
# so instead of 
# <% if current_user && current_user.admin? %>
# ...
# <% end %>
#
# we end up with
# <% site_admin_content do %>
# ...
# <% end %>
#
# To display something only to an object's editor, let's say
# we have @venue, we can use something like this
# <% editor_content(@venue) do %>
#  ...
# <% end %>
#
module ConditionalBlockHelper

  def site_admin_content(&block)
    concat(capture(&block)) if current_user && current_user.admin?
  end

  def editor_content(object, &block)
    concat(capture(&block)) if object.editable_by?(current_user)
  end
  
  def iphone_content(&block)
    concat(capture(&block)) if iphone_request?
  end

  def non_iphone_content(&block)
    concat(capture(&block)) unless iphone_request?
  end
end
