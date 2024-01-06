class ApplicationController < ActionController::API
  include JsonWebToken

  rescue_from StandardError, with: :render_standard_error
  before_action :authenticated?

  def authenticated?
    token = request.headers["Authorization"]
    token = token.chomp.split(" ").last if token

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded["user_id"])
    rescue ActiveRecord::RecordNotFound
      render_unuthorized
    rescue JWT::DecodeError
      render_unuthorized
    end
  end

  private
    def render_unuthorized
      render json: { error: "unuthorized", status: 401 }
    end

    def create_render_json(user)
      token = JsonWebToken.encode({ user_id: user[:id] })
      response = { user: { email: user[:email], token:, username: user[:username], bio: user[:bio], image: user[:image] } }
      response
    end

    def render_standard_error(error)
      render json: { error: error.message, location: error.backtrace }, status: :internal_server_error
    end
end
