Rails.application.routes.draw do
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

  resources :orders, only: [:new, :create, :show, :index] do
    collection do
      post :update_summary
    end
  end

  get 'payments/new'
  post '/payments', to: 'payments#create'
  get 'payments/success', to: 'payments#success'
  get 'payments/cancel', to: 'payments#cancel', as: :payments_cancel


  get'billing', to: 'billing#show'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

end
