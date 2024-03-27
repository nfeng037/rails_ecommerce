Rails.application.routes.draw do
  get 'cart/show'
  get 'static_pages/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'pages/:identifier', to: 'static_pages#show', as: :static_page
  resources :products, path: 'product'
  get 'search/index'
  get '/search', to: 'search#index'
end
