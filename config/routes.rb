Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :words, only: [:index, :create, :destroy]
  # Other routes for your application
end
