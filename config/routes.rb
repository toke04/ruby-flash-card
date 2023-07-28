# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_ruby_methods, except: %i[new show]
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
      resources :user_ruby_methods
      post 'exec_code', to: 'user_ruby_methods#exec_code'
    end
  end

  get 'quiz/new'
  get 'quiz/show'
  root 'home#index'
  get 'terms_of_service', to: 'home#terms_of_service', as: 'terms_of_service'
  get 'privacy_policy', to: 'home#privacy_policy', as: 'privacy_policy'
end
