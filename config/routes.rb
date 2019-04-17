# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'auth/passwords'
  }

  resource :game_setting

  resource :products, only: [] do
    get '/:identifier', to: 'products#index'
  end
  resources :ticket_transactions, only: %i[index create]
  resource :orders, only: [] do
    post '/', to: 'orders#create'
  end
end
