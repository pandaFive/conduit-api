class ArticlesController < ApplicationController
  def create
    article = @current_user.articles.build(article_params)
    tags = params[:article][:tagList]

    if article.save
      tags.each do |tag|
        article_tag = article.tags.create(name: tag)
      end

      render json: { article: generate_article_response(article, tags) }
    else
      render json: article.errors, status: 422
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description, :body)
    end

    def generate_article_response(article, tags)
      user = User.find(article.user_id)
      author = { username: user.username }
      response = { slug: article.slug, title: article.title, description: article.description, body: article.body, tagList: tags, createdAt: article.created_at, updatedAt: article.updated_at, author: author }
      response
    end
end
