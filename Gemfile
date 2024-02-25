source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails",       "~> 7.0.8"
gem "puma",        "~> 5.0"
gem "dotenv-rails"
gem "jwt",         "~> 2.7", ">= 2.7.1"
gem "bcrypt",      "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap",    require: false
gem "rack-cors",   "~> 2.0", ">= 2.0.1"
gem "faker",       "~> 3.2", ">= 3.2.2"
gem "sentry-ruby"
gem "sentry-rails"

group :production do
  gem "mysql2",      "~> 0.5"
end

group :development, :test do
  gem "debug",  ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "sqlite3",     "~> 1.4"
  gem "solargraph", "0.50.0"
  gem "rubocop",             require: false
  gem "rubocop-rails",       require: false
  gem "rubocop-minitest",    require: false
  gem "rubocop-performance", require: false
  gem "rubocop-packaging",   require: false
  gem "rubocop-md",          require: false
end

group :test do
  gem "minitest",                "~> 5.20"
  gem "minitest-reporters",      "~> 1.6", ">= 1.6.1"
  gem "guard",                   "~> 2.18", ">= 2.18.1"
  gem "guard-minitest",          "~> 2.4", ">= 2.4.6"
  gem "simplecov",               require: false
  gem "rails-controller-testing"
  gem "selenium-webdriver",      "~> 4.16"
  gem "capybara",                "~> 3.39", ">= 3.39.2"
end
