class Article < ApplicationRecord
  belongs_to :user
  before_save :generate_slug
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :favorites
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  validates :description, presence: true
  validates :body, presence: true

  def generate_slug
    self.slug = self.title.parameterize if title.present?
  end

  def to_param
    slug
  end

  def generate_response(user)
    response = {
      slug: self.slug,
      title: self.title,
      description: self.description,
      body: self.body,
      tagList: self.tags.pluck(:name),
      createdAt: self.created_at,
      updatedAt: self.updated_at,
      favorited: favorited?(user),
      favoritesCount: get_favorite_count,
      author: self.user.generate_profile_response
    }
    response
  end

  def get_favorite_count
    favorite = Favorite.where(article_id: self.id)
    count = favorite ? favorite.count : 0
    count
  end

  def favorited?(user)
    favorite = Favorite.find_by(article_id: self.id, user_id: user.id)
    !!favorite
  end
end
