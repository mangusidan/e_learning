Rails.application.routes.draw do
  get "sessions/new"
  get "users/new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  root "static_pages#home"
  get "static_pages/home"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users
end
