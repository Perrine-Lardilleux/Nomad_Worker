Rails.application.routes.draw do
  devise_for :users
  root to: 'cities#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cities, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :wishlists, only: [:create, :destroy]
  end
  resources :wishlists, only: :index
end
