require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    post api_users_path, params: { user: { username: "example",
                                         email: "example@test.com",
                                         password: "password" } }
    @token = JSON.parse(response.body)["user"]["token"]
  end

  test "valid create article" do
    assert_difference "Article.count", 1 do
      post api_articles_path, params: { article: { title: "How to train your dragon",
                                                  description: "Ever wonder how?",
                                                  body: "You have to believe",
                                                  tagList: ["reactjs", "angularjs", "dragons"] } },
                              headers: { Authorization: @token }
    end
  end

  test "invalid create article" do
    assert_no_difference "Article.count" do
      post api_articles_path, params: { article: { title: "How to train your dragon",
                                                   description: "Ever wonder how?",
                                                   tagList: ["reactjs"] } },
                              headers: { Authorization: @token }
    end
    assert_response 422
  end

  test "invalid authorized" do
    assert_no_difference "Article.count" do
      post api_articles_path, params: { article: { title: "How to train your dragon",
                                                  description: "Ever wonder how?",
                                                  body: "You have to believe",
                                                  tagList: ["reactjs", "angularjs", "dragons"] } },
                              headers: { Authorization: "333" }
    end
    assert_response :unauthorized
  end

  test "valid get article" do
    get api_articles_path(slug: "how-to-train-your-dragon"), headers: { Authorization: @token }
    assert_response :success
  end

  test "invalid get article" do
    get api_articles_path(slug: "jfeoaifjeoiajfea;lgiejao;i"), headers: { Authorization: @token }
    assert_response :success
  end
end
