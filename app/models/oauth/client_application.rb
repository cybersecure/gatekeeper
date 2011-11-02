class Oauth::ClientApplication < ActiveRecord::Base
  belongs_to  :user
  has_many  :access_grants

  def self.authenticate(app_id,app_secret)
    find_by_app_id_and_app_secret(app_id,app_secret)
  end
end
