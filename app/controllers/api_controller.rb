class ApiController < ActionController::Base
  protect_from_forgery

  before_filter :require_api_key

  helper_method :current_user

  private
  
  def require_api_key
    render(:nothing => true, :status => :unauthorized) unless current_api_user
  end

  def current_api_user
    begin
      @api_user ||= User.find_by_api_key(params[:api_key])
    rescue ActiveRecord::RecordNotFound
      # if api_key not found, just handle 
    end
  end

end
