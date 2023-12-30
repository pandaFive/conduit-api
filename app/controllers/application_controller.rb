class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticated?

  def authenticated?
    token = request.headers["Authorization"]
    token = token.chomp.split(" ").last if header

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded["user_id"])
    rescue ActiveRecord::RecordNotFound
      render_unuthorized
    rescue JWT::DecodeError
      render_unuthorized
    end
  end

  def render_unuthorized
    render json: { error: "unuthorized", status: 401 }
  end
end
