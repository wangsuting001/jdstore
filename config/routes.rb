Rails.application.routes.draw do
  devise_for :users

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :products
  end

  namespace :account do
    resources :orders
  end

  resources :products, only: [:show, :index] do
    member do
      post :add_to_cart
    end
  end

  resources :carts, only: [:index] do
    collection do
       delete :clean
       post :checkout
    end
  end

  resources :cart_items

  resources :orders
end
