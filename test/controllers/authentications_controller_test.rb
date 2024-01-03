require "test_helper"

class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    post api_users_path, params: { user: { username: "example",
                                         email: "example@test.com",
                                         password: "password" } }
    @token = JSON.parse(response.body)["user"]["token"]
  end

  test "valid login" do
    post api_users_login_path, params: { user: { email: "example@test.com",
                                                 password: "password" } }
    token = JSON.parse(response.body)["user"]["token"]
    assert_equal @token, token
  end

  test "invalid login" do
    post api_users_login_path, params: { user: { email: "fejoiaj@test.com",
                                                 password: "password" } }
    assert_response :unprocessable_entity
  end
end
