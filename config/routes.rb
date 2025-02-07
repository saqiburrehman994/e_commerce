Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
  resources :products do
    resources :reviews, except: [:index]
  end
  resource :cart, only: [:show]
  resources :cart_items, only: [:edit, :create, :update, :destroy]
  resources :orders, only: [:index, :show] do
    collection do
      post :checkout
      get :manage
    end
    member do
      patch :update_status
    end
  end
  resources :shipping_details, only: [:new, :create, :update, :edit]
  resources :payment_details, only: [:new, :create, :destroy]
  namespace :manager do
    get "dashboard", to: "dashboard#index"
  end
end
