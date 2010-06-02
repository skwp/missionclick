# This is a hack to allow a single-password login to access event editing
# This will go away in the actual release
class MappAdminLoginController < ApplicationController
  skip_before_filter :show_beta_screen

  def login
    if request.post?
      if params[:password] == 'mapperos'
        session[:mapp_admin] = true
        flash[:notice] = "You are now able to edit events."
        redirect_to mapp_path
      else
        flash.now[:notice] = "Sorry, wrong password. Email contact@missionclick.com for editing rights."
      end
    end

  end
end
