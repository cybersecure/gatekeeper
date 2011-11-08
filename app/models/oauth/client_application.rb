class Oauth::ClientApplication < ActiveRecord::Base
  belongs_to  :user
  has_many  :access_grants

  def self.authenticate(client_id,client_secret)
    find_by_client_id_and_client_secret(client_id,client_secret)
  end
end
