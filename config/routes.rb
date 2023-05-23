Rails.application.routes.draw do
  devise_for :users

  root to: "words#index"

  resources :users do
    resources :words
  end

  resources :words, only: [:destroy]
end
