Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations'
  }
  root to: 'pages#home'
  namespace :admin do
    resources :products, only: %i[index show new create edit update]
  end

  scope module: :customer do
    resources :products, only: %i[index show]
    resources :cart_items, only: %i[index create destroy] do
      member do # cart_item の id が含まれる URL を作成
        patch 'increase'
        patch 'decrease'
      end
    end
  end

  get '/up/', to: 'up#index', as: :up
  get '/up/databases', to: 'up#databases', as: :up_databases
end
