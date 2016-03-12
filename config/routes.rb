Rails.application.routes.draw do
  resources :books, only: [:index, :new, :create]
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :home, only: :show
  root 'home#index'
  get 'access_denied', to: 'home#access_denied'
  namespace :admin do
    get 'home', to: 'home#index'
    resources :books, only: [:index, :destroy]
    resources :categories, except: [:new, :show]
    resources :users, except: [:new, :show]
    get 'show', to: 'users#show'
  end
end
