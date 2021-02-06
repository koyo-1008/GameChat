Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :groups, only: :index
  resources :channels, only: [:index, :create]
  resources :comments, only: [:index, :create, :destroy]
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
