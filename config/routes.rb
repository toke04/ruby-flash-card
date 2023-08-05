# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_ruby_methods, except: %i[new create show]
  resources :ruby_methods
  resources :ruby_modules

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    delete 'logout', to: 'users/omniauth_callbacks#destroy', as: 'logout'
  end

  namespace 'api' do
    namespace 'v1' do
      resources :user_ruby_methods, only: %i[create update]
    end
  end

  get 'flash_card/new'
  get 'flash_card/show'
  root 'home#index'
  get 'terms_of_service', to: 'home#terms_of_service', as: 'terms_of_service'
  get 'privacy_policy', to: 'home#privacy_policy', as: 'privacy_policy'
end
