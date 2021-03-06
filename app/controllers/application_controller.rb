class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?
  before_action :ensure_signed_in

  private
  
  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to user_url(user)
  end

  def sign_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
