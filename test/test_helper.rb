ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "../app/controllers/concerns/json_web_token"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_token(user)
    token = JsonWebToken.encode({ user_id: user[:id] })
    token
  end
end
