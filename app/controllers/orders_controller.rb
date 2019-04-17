# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    order = shopify_order(params[:product_id], current_user)

    if order.attributes['status'] == 'open'
      render json: {
        id: 'success', message: 'You have Claim your prize!'
      }, status: :created
    else
      render json: {
        id: 'error', message: 'There was an error with your Claim.'
      }, status: :unprocessable_entity
    end
  end

  private

  def shopify_order(product_id, current_user)
    ShopifyAPI::DraftOrder.create(
      line_items: [{ variant_id: product_id, quantity: 1 }],
      customer: { id: current_user.shopify_customer_id },
      use_customer_default_address: true,
      financial_status: 'paid'
    )
  end
end
