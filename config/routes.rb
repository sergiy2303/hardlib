Rails.application.routes.draw do
  resources :books, only: [:index, :new, :create, :destroy]
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'home#index'
end
