module Authentication
  class SessionsController < ApplicationController
    def new
      redirect_to_target_or_default root_url, :notice => "Already Logged in!" if current_user
    end

    def create
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        redirect_to_target_or_default root_url, :notice => "Logged In"
      else
        flash.now[:alert] = "Invalid credentials"
        render :action => 'new'
      end
    end

    def destroy
      cookies.delete(:auth_token)
      redirect_to root_url, :notice => "Logged Out!"
    end
  end
end
