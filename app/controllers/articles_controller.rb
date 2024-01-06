class ArticlesController < ApplicationController
  def create
    article = @current_user.articles.build(article_params)
    tags = params[:article][:tagList]

    if article.save
      tags.each do |tag|
        article.tags.create(name: tag)
      end

      render json: { article: article.generate_response(@current_user) }
    else
      render json: article.errors, status: 422
    end
  end

  def list
    articles = Article.search_article(search_params)

    if articles.length > 1
      response = articles.reduce([]) do |res, article|
        res.push(article.generate_response(@current_user))
      end

      render json: { articles: response, articlesCount: articles.length }
    else
      if articles.length >= 0
        if articles[0] == nil
          render json: { article: {} }
        else
          render json: { article: articles[0].generate_response(@current_user) }
        end
      else
        render json: { status: 402 }, status: :unprocessable_entity
      end
    end
  end

  def get
    article = Article.find_by(slug: params[:slug])

    if article
      render json: { article: article.generate_response(@current_user) }
    else
      render json: { message: "not found", status: 404 }
    end
  end

  def update
    current_article = Article.find_by(slug: params[:slug])
    if current_article.update(article_params)
      render json: { article: generate_response(@current_user) }
    else
      render json: { message: current_article.errors.full_messages.join(" "), status: 422 }
    end
  end

  def destroy
    Article.find_by(slug: params[:slug]).destroy
  end

  private
    def article_params
      params.require(:article).permit(:title, :description, :body)
    end

    def search_params
      params.permit(:tag, :author, :favorited, :limit, :offset)
    end
end
