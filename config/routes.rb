require 'sidekiq/web'

Rails.application.routes.draw do
  draw :madmin
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'

  namespace :madmin do
    resources :impersonates do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end
end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products do
    resources :reviews, only: [:create, :update, :destroy]
  end
  resources :carts, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
  end

  resources :orders, only: [:new, :create, :show]

  # Alternatively, you can use this for a single user's cart
  resource :cart, only: [:show]
  resources :orders, only: [:index, :show, :create]
  root 'products#index'
end
