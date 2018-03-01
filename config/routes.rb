Rails.application.routes.draw do
  devise_for :users
  post '/users/:id',  to: 'users#send_mail'
  post '/greetings_mail', to: 'users#send_greetings_to_users'
  resources :users, only: [:index, :destroy]
  resources :admins, only: :index
  root 'users#index'
end
