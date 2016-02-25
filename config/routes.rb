Rails.application.routes.draw do
  resources :books, only: [:index, :new, :create, :destroy]
  devise_for :users
  root 'home#index'
end
