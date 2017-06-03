Rails.application.routes.draw do
  root 'sessions#show'

  resources :users, only: [:new, :create]
  resources :items, only: [:index, :show]
  resources :categories, only: [:index, :show]

  namespace :admin do

    get '/dashboard', to: 'dashboard#index'

    resources :orders, only: [:update]
    resources :items, only: [:new, :create]
  end

  namespace :patron do
    resources :orders, only: [:new, :create, :index, :show]
    resources :users, only: [:show]
  end

  get '/dashboard', to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'
  put '/cart', to: 'cart#update'
end
