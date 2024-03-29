class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :redirect_to_target_or_default, :current_user_from_oauth

  private 

  def current_user
    if cookies[:auth_token]
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    else
      current_user_from_oauth
    end
  end

  def current_user_from_oauth
    access_token ||= params[:access_token]  
    if access_token.nil?
      nil
    else
      grant = Oauth::AccessGrant.find_by_access_token(access_token)
      if grant.nil?
        nil
      else
        @current_user = grant.user
      end
    end
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to login_url, :alert => "You must first log in before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end
  
  def store_target_location
    session[:return_to] = request.url
  end
end
