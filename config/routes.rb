# frozen_string_literal: true

Rails.application.routes.draw do
  resource :products, only: [] do
    get '/:identifier', to: 'products#index'
  end
end
