module Oauth
  class AuthRequestsController < ApplicationController
    before_filter :login_required

    def new
      AccessGrant.prune!
      application ||= ClientApplication.find_by_client_id(params[:client_id])
      if application.nil?
        raise "Client Application identifier is not valid"
      end
      access_grant = current_user.access_grants.create(:application => application)
      redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
    end
  end
end
