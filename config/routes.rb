Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "search", to: "pages#search"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :vans, only: %i[index show] do
    resources :reviews, only: %i[index new create]
    get "tracking" => "vans#tracking", as: :tracking
    get "orders" => "vans#orders", as: :orders
    get "products/:id" => "products#show", as: :product
    patch "products/:id" => "products#update"
    resources :orders, only: %i[show create update destroy]
    resources :inventories
    post "favourite" => "favourites#create", as: :favourite
  end

  resources :orders, only: %i[index show new create] do
    get "checkout" => "orders#checkout", as: :checkout
    resources :order_products, only: %i[create destroy]
  end

  resources :favourites, only: %i[index destroy]
end
