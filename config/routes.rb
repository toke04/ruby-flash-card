Rails.application.routes.draw do
  devise_for :users
  resources :user_ruby_methods
  resources :ruby_methods
  resources :ruby_modules
  get 'home/index'
  root to: "home#index"

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # root "articles#index"
end
