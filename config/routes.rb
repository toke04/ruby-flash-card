Rails.application.routes.draw do
  resources :user_ruby_methods
  resources :ruby_methods
  resources :ruby_modules
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'home/index'
  root to: "home#index"

  # root "articles#index"
end
