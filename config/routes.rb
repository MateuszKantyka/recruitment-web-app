Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :destroy]
  resources :admins, only: :index
  root 'users#index'
end
