class AuthenticationsController < ApplicationController
  skip_before_action :authenticated?, only: [:login]

  def login
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      render json: create_render_json(user)
    else
      render json: { message: user.errors.full_message.join(" "), status: 402 }, status: :unprocessable_entity
    end
  end
end
