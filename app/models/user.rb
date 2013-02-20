class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  belongs_to :user_group

  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      # create salt (if needed) This allows testing of encryption:
      self.password_salt = ::BCrypt::Engine.generate_salt unless password_salt
      # Now encrypt the password and set that in the column
      self.password_hash = ::BCrypt::Engine.hash_secret(password, password_salt)
    end
    # generate an API key for the user
    if self.api_key.nil? and self.email and self.password_salt
      self.api_key = Digest::SHA1.hexdigest( BCrypt::Engine.hash_secret(email, password_salt) )
    end
  end

end
