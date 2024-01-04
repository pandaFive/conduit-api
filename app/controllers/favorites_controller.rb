class FavoritesController < ApplicationController
  def create
    current_article = Article.find_by(slug: params[:slug])
    favorite = Favorite.new(user_id: @current_user.id, article_id: current_article.id)

    if favorite.save
      render json: { article: current_article.generate_response(@current_user) }
    else
      if favorite
        render json: { status: 402, message: favorite.errors.full_messages[0] }, status: :unprocessable_entity
      else
        render json: { status: 402 }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    current_article = Article.find_by(slug: params[:slug])
    Favorite.find_by(user_id: @current_user.id, article_id: current_article.id).destroy
    render json: { article: current_article.generate_response(@current_user) }
  end
end
