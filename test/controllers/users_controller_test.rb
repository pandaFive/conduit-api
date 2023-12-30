require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get registration" do
    get users_registration_url
    assert_response :success
  end
end
