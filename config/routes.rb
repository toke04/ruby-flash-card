Rails.application.routes.draw do
  resources :user_ruby_methods
  resources :ruby_methods
  resources :ruby_modules
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_scope :user do
    delete 'logout', to: 'users/omniauth_callbacks#destroy', as: 'logout'
  end

  namespace 'api' do
    namespace 'v1' do
      resources :user_ruby_methods
    end
  end

  get 'quiz/new'
  get 'quiz/show'
  get 'home/index'
  root to: "home#index"

  # root "articles#index"
end
