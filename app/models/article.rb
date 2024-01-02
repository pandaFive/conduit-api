class Article < ApplicationRecord
  before_save :generate_slug
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  def generate_slug
    self.slug = self.title.parameterize if title.present?
  end

  def to_param
    slug
  end
end
