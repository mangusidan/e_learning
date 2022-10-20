Rails.application.routes.draw do
  root "static_pages#home"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, only: [:create, :index, :edit, :update, :show]
  resources :words, only: [:index]
  resources :categories, only: [:index, :show]
  resources :users do
    get "/:relationship", on: :member,
      to: "relationships#index", as: :relationships
  end
  resources :lessons, only: [:show, :create, :update]
  resources :relationships, only: [:create, :destroy, :index]
  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
    resources :words, only: [:index]
    resources :categories do
      resources :words
    end
  end
end
