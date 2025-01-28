Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :vans, only: %i[index show] do
    resources :reviews, only: %i[index new create]
    get "tracking" => "vans#tracking", as: :tracking
    get "orders" => "vans#orders", as: :orders
    get "products/:id" => "products#show", as: :product
    resources :orders, only: %i[update destroy]
    resources :inventories
    post "favourite" => "favourites#create", as: :favourite
  end

  resources :orders, only: %i[index show] do
    get "checkout" => "orders#checkout", as: :checkout
    resources :order_products, only: %i[create destroy]
  end

  resources :favourites, only: %i[index destroy]
end
