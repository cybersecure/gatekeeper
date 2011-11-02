module Oauth
  class SessionsController < ApplicationController
    def destroy
      cookies.delete(:auth_token)
      render :json => { :logout => true }
    end
  end
end
