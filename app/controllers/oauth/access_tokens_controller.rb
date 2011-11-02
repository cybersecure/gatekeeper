module Oauth
  class AccessTokensController < ApplicationController
    def new
      application = ClientApplication.authenticate(params[:client_id],params[:client_secret])
    
      if application.nil?
        render :json => {:error => "Could not find the application" }
        return
      end

      access_grant = AccessGrant.authenticate(params[:code],application.id)

      if access_grant.nil?
        render :json => {:error => "Could not authenticate access code" }
        return
      end

      access_grant.start_expiry_period!
      
      render :json => { 
          :access_token => access_grant.access_token,
          :refresh_token => access_grant.refresh_token,
          :expires_in => access_grant.access_token_expires_at 
      }
    end
  end
end
