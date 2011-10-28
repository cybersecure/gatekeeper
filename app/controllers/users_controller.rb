class UsersController < ApplicationController
#  authenticate_with_oauth
  before_filter :set_current_account_from_oauth, :only => [:show]

  def show
    user = User.find(1)
    render :json => {:login => user.username}
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
  
  private

  def set_current_account_from_oauth
    @current_user = request.env['oauth2'].resource_owner
  end
end
