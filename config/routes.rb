# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'auth/passwords'
  }

  resource :game_setting
  resources :admin_texts, only: %i[index]

  resource :products, only: [] do
    get '/:identifier', to: 'products#index'
  end
  resources :ticket_transactions, only: %i[index create]
  resources :purchase_options, only: %i[index]
  resource :orders, only: [] do
    post '/', to: 'orders#create'
  end
  resource :payments, only: [] do
    post '/', to: 'payments#create'
  end
  resource :cards, only: [] do
    get '/', to: 'cards#index'
  end
end
