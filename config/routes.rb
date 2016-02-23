Rails.application.routes.draw do
  resources :resumes, only: [:index, :new, :create, :destroy]
  devise_for :users
  root 'home#index'
end
