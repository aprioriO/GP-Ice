Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "search", to: "pages#search"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :vans, only: %i[index show] do
    resources :reviews, only: %i[index new create]
    get "tracking", to: "vans#tracking", as: :tracking
    get "orders", to: "vans#orders", as: :orders
    get "products/:id", to: "products#show", as: :product
    resources :orders, only: %i[show update destroy]

    get "cart", to: "order_products#show", as: :cart
    post "cart/add/:product_id", to: "order_products#create", as: :add_to_cart
    delete "cart/remove/:product_id", to: "order_products#destroy", as: :remove_from_cart
    delete "cart/clear", to: "order_products#clear", as: :clear_cart
  end

  resources :orders, only: %i[index show new create] do
    get "checkout", to: "orders#checkout", as: :checkout
  end

  resources :favourites, only: %i[index destroy]
end
