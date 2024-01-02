class Article < ApplicationRecord
  belongs_to :user
  before_save :generate_slug
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
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
end
