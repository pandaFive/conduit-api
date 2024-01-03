require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "invalid signup registration" do
    assert_no_difference "User.count" do
      post api_users_path, params: { user: { username: "eeee",
                                             email: "bar",
                                             password: "foo" } }
    end
    assert_response :unprocessable_entity
  end

  test "valid signup registration" do
    assert_difference "User.count", 1 do
      post api_users_path, params: { user: { username: "example",
                                             email: "example@test.com",
                                             password: "password" } }
    end
  end
end
