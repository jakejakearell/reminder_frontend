class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_presence_of :password, require: true

  has_secure_password
end
