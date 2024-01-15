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

  scope :limit_on, -> (limit) { take(limit) }
  scope :offset_on, -> (offset) { offset(offset) }
  scope :author_in, -> (name) {
    joins(:user).where(users: { username: name })
  }
  scope :favorited_in, -> (name) {
    joins(:favorites).where(favorites: { user_id: User.where(username: name).pluck(:id) })
  }
  scope :tags_in, -> (tag_name) {
    joins(:tags).where(tags: { name: tag_name })
  }

  def self.search_article(params)
    result = Article.all

    result = result.author_in(params[:author]) if params[:author]
    result = result.favorited_in(params[:favorited]) if params[:favorited]
    result = result.tags_in(params[:tag]) if params[:tag]
    result = result.limit_on(params[:limit]) if params[:limit]
    result = result.offset_on(params[:offset]) if params[:offset]
    result = result.limit_on(20) unless params[:limit]

    result
  end

  def generate_slug
    self.slug = self.title.parameterize if title.present?
  end

  def to_param
    slug
  end

  def generate_response(user = false)
    favorited = !user ? false : favorited?(user)
    response = {
      slug: self.slug,
      title: self.title,
      description: self.description,
      body: self.body,
      tagList: self.tags.pluck(:name).sort,
      createdAt: self.created_at,
      updatedAt: self.updated_at,
      favorited:,
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
