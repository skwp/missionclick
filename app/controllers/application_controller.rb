# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :detect_iphone
  before_filter :check_mapp_admin
  before_filter :show_beta_screen if APP_CONFIG[:mapp_only_alpha]

  protected

  def detect_iphone
    if params[:force_iphone] || request.user_agent.include?("iPhone") then 
      @iphone = true
    end
  end

  # A simple way to prevent actions from being accessed by non-admins
  # Usage:
  #   require_admin :only => [:create, :update, :destroy] 
  #   require_admin :except => [:show, :index]
  #   
  def self.require_admin(options = {})
    before_filter :check_admin_authorization

    define_method(:check_admin_authorization) do
      if options[:only]
        return_error_unless_admin if options[:only].map(&:to_s).include?(params[:action])
      elsif options[:except]
        return_error_unless_admin unless options[:except].map(&:to_s).include?(params[:action])
      else
        return_error_unless_admin
      end
    end
  end

  private

  def show_beta_screen
    render :template => 'shared/beta' #unless current_user && current_user.admin?
  end

  def check_mapp_admin
    if session[:mapp_admin]
      @editable = true
      @mapp_admin = true
    end
  end

  def return_error_unless_admin
    if current_user && current_user.admin?
      true
    else
      respond_to do |format|
        format.html {
            flash[:alert] = "You must be an administrator to do that. Please sign in."
            redirect_to new_session_path(:user)
        }
        format.xml  { head :forbidden }
      end
    end
  end

end
