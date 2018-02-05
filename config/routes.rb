Rails.application.routes.draw do
  devise_for :users
  post '/users/:id',  to: 'users#send_mail'
  resources :users, only: [:index, :destroy]
  resources :admins, only: :index
  root 'users#index'
end
