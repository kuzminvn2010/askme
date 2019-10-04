require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :email, email: true
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: {maximum: 40}, format: {with: /[a-zA-z0-9_]/}


  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_save :encript_password
  before_validation :username_downcase

  def encript_password
    if self.password.present?
      # создаем рандомную строку, с помощью которой будет шифроваться пароль
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      # создаем длинную уникальную строку (хэш)
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
        )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def username_downcase
    self.username.downcase!
  end
end
