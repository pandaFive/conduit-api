class ArticlesController < ApplicationController
  def create
    article = @current_user.articles.build(article_params)
    tags = params[:article][:tagList]

    if article.save
      tags.each do |tag|
        article_tag = article.tags.create(name: tag)
      end

      render json: { article: generate_article_response(article) }
    else
      render json: article.errors, status: 422
    end
  end

  def list
    limit = params[:limit] || 20

    articles = Article.limit(limit)

    if articles.length > 1
      response = articles.reduce([]) do |res, article|
        res.push(generate_article_response(article))
      end

      render json: { articles: response, articlesCount: articles.length }
    else
      render json: { article: generate_article_response(articles[0]) }
    end
  end

  def get
    article = Article.find_by(slug: params[:slug])

    if article
      render json: { article: generate_article_response(article) }
    else
      render json: { message: "not found", status: 404 }
    end
  end

  def destroy
    Article.find_by(slug: params[:slug]).destroy
  end

  private
    def article_params
      params.require(:article).permit(:title, :description, :body)
    end

    def generate_article_response(article)
      user = User.find(article.user_id)
      tags = article.tags.pluck(:name)
      author = { username: user.username }
      response = { slug: article.slug, title: article.title, description: article.description, body: article.body, tagList: tags, createdAt: article.created_at, updatedAt: article.updated_at, author: author }
      response
    end
end
