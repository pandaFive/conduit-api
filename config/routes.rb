Rails.application.routes.draw do
  post "/api/users",            to: "users#registration"
  post "/api/users/login",      to: "authentications#login"
  post "/api/articles",         to: "articles#create"
  get  "/api/articles",         to: "articles#list"
  get  "/api/articles/:slug",   to: "articles#get"
  put  "/api/articles/:slug",   to: "articles#update"
  delete "/api/articles/:slug", to: "articles#destroy"
end
