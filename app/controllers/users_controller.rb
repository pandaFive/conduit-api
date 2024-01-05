class UsersController < ApplicationController
  skip_before_action :authenticated?, only: [:registration]

  def get
    render json: create_render_json(@current_user)
  end

  def update
    if @current_user.update(user_params)
      render json: create_render_json(@current_user)
    else
      render json: { message: @current_user.errors[-1], status: 422 }, status: :unprocessable_entity
    end
  end

  def registration
    user = User.new(user_params)

    if user.save
      render json: create_render_json(user)
    else
      render json: { message: user.errors.full_messages.join(" "), status: 422 }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
