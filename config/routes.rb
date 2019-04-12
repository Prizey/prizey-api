# frozen_string_literal: true

Rails.application.routes.draw do
  resources :game_settings, only: %i[index]
  resource :products, only: [] do
    get '/:identifier', to: 'products#index'
  end
end
