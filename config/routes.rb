Rails.application.routes.draw do
  get "sessions/new"
  get "users/new"
  root "static_pages#home"
  get "static_pages/home"
end
