Rails.application.routes.draw do
  resources :books, only: [:index, :new, :create, :destroy]
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'home#index'
  get 'access_denied', to: 'home#access_denied'
end
