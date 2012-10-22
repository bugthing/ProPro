class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_presence_of :password, :on => :create

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email( email )
    return user if ( user && user.password_hash == ::BCrypt::Engine.hash_secret(password, user.password_salt) ) 
    nil
  end

  def encrypt_password
    if password.present? 
      # create salt (if needed) This allows testing of encryption:
      self.password_salt = ::BCrypt::Engine.generate_salt unless password_salt
      # Now encrypt the password and set that in the column
      self.password_hash = ::BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
