class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    User.select(User.attribute_names - ['password_digest']).find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  private
    def require_login
      return redirect_to login_path unless session[:user_id]
    end
end
