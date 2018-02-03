Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :admins, only: :index
  root 'users#index'
end
