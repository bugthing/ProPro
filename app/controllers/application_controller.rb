class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private
  
  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to :sign_up
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      # if session id is invalid, just handle 
    end
  end

end
