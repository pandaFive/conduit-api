class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :favorites
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGES = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGES },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def generate_profile_response
    response = {
      username: self.username,
      bio: self.bio,
      image: self.image,
    }
    response
  end
end
