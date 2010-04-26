class TaggingsController < ApplicationController
  def create
    e = Event.find(params[:event_id])
    e.tag_list = params[:tag_list]
    e.save

    respond_to do |format|
      format.js {
        render(:update) do |page|
            page.replace_html "tags_#{e.id}", render_tags(e.tags)
            page.visual_effect :highlight, "tags_#{e.id}"
            page.hide "edit_tags_#{e.id}"
        end
      } 
    end
  end
end
