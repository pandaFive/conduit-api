Rails.application.routes.draw do
  post   "/api/users",                    to: "users#registration"
  post   "/api/users/login",              to: "authentications#login"
  get    "/api/user",                     to: "users#get"
  put    "/api/user",                     to: "users#update"
  post   "/api/articles",                 to: "articles#create"
  get    "/api/articles",                 to: "articles#list"
  get    "/api/articles/:slug",           to: "articles#get"
  put    "/api/articles/:slug",           to: "articles#update"
  delete "/api/articles/:slug",           to: "articles#destroy"
  post   "/api/articles/:slug/favorites", to: "favorites#create"
  delete "/api/articles/:slug/favorites", to: "favorites#destroy"
end
