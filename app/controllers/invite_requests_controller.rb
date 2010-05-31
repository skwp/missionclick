class InviteRequestsController < ApplicationController
  skip_before_filter :show_beta_screen

  def create
    InviteRequest.create(params[:invite_request])
    flash[:notice] = "Thanks! We'll be in touch soon."
    redirect_to root_path
  end
end
