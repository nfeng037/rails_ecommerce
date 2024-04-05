Rails.application.routes.draw do
  devise_for :users
  root 'products#index'

  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  post 'cart/decrease'
  post 'cart/update'

  get 'static_pages/index'
  get 'pages/:identifier', to: 'static_pages#show', as: :static_page


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, path: 'product'

  get 'search/index'
  get '/search', to: 'search#index'
end
