Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :admins, only: :index
  root 'users#index'
end