Rails.application.routes.draw do
  post "/api/users",      to: "users#registration"
  post "/api/users/login", to: "authentications#login"
end
