Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :destroy]
  get '/admin_panel', to: 'users#admin_panel'
  root 'users#index'
end
