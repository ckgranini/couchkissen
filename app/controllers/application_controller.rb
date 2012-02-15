class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def require_login
    if current_user.nil?
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorized?(user)
    current_user.id == user.id
  end
  helper_method :authorized?

end
