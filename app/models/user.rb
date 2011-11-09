class User

# https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
# This class implements the has_secure_password, which is not supported by datamapper.
# So we need to replicate that functionality here
# 
# TODO : replace it with actual code
# 
# has_secure_password
#

  include DataMapper::Resource
  
  property :id,                     Serial
  property :username,               String, :required => true
  property :email,                  String, :required => true
  property :password_digest,        String, :required => true
  property :password_reset_token,   String
  property :login_token,            String
  property :active,                 Boolean, :required => true
  property :admin,                  Boolean, :required => true
  property :password_reset_sent_at, DateTime
      
  has n,  :access_grants, :through => Oauth::AccessGrant

  attr_accessible :username, :email, :password, :password_confirmation, :language
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :username
  validates_uniqueness_of :username

  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
