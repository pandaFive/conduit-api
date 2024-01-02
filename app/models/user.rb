class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGES = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGES },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
end
