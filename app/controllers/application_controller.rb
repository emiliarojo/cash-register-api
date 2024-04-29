class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :log_session_info

  private

  def log_session_info
     logger.info "Current session ID: #{session[:session_id]}"
  end
end
