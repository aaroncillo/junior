Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :products
  resources :sales
  get 'stock', to: 'products#stock'
  get 'fetch_products', to: 'sales#fetch_products'
end
