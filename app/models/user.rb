require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates_presence_of :name, :email
  validates_length_of :name, :maximum => 50
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_uniqueness_of :email, :case_sensitive => false
  validates_confirmation_of :password
  validates_length_of :password, :within => 6..40
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypt(submitted_password) == self.encrypted_password
  end
  
  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end
  
  def self.authenticate(email_address, password)
    user = User.find_by_email email_address
    return nil if user.nil?
    return user if user.has_password? password
  end
  
  private
  
    def encrypt_password
      unless password.nil?
        self.salt = secure_hash("#{Time.now.utc}#{password}")
        self.encrypted_password = encrypt(password)
      end
    end
    
    def encrypt(string_to_encrypt)     
      secure_hash("#{salt}#{string_to_encrypt}")
    end
    
    def secure_hash(string_to_secure)
      Digest::SHA2.hexdigest(string_to_secure)
    end
end
