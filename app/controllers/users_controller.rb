class UsersController < ApplicationController
  skip_before_action :authenticated?, only: [:registration]

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
