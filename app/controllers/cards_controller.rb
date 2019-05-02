# frozen_string_literal: true

class CardsController < ApplicationController
  # rubocop:disable Style/BracesAroundHashParameters
  def index
    all_cards = Stripe::Customer.list_sources(
      current_user.stripe_customer_id, { object: 'card' }
    )

    serialized = all_cards['data'].map do |card|
      { id: card['id'],
        last4: card['last4'],
        brand: card['brand'] }
    end

    render json: serialized, status: :ok
  end
  # rubocop:enable Style/BracesAroundHashParameters
end
