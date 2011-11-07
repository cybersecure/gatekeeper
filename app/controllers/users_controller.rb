class UsersController < ApplicationController
  def show
    if current_user
      result = {:username => current_user.username}
    else
      result = {:error => "access_denied" }
    end
    respond_to do |format|
      format.json { render :json => result.to_json }
      format.html { login_required }
    end
  end

  def new
    if current_user
      redirect_to_target_or_default root_url, :alert => "Please logout to signin as other account"
    end
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => "Successfully signed up"
    else
      render "new"
    end
  end
end
