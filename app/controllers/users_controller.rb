class UsersController < ApplicationController
  include JsonWebToken
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

    def create_render_json(user)
      token = JsonWebToken.encode({ user_id: user[:id] })
      response = { user: { email: user[:email], token:, username: user[:username], bio: user[:bio], image: nil } }
      response
    end
end
