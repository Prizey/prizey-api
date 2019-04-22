# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    order = shopify_order(params[:product_id])

    if order.attributes['confirmed'].present?
      render json: {
        id: 'success', message: 'You have claimed your prize!'
      }, status: :created
    else
      render json: {
        id: 'error', message: 'There was an error with your claim.'
      }, status: :unprocessable_entity
    end
  end

  private

  def shopify_order(product_id)
    ShopifyAPI::Order.create(
      line_items: [{ variant_id: product_id, quantity: 1 }],
      email: current_user.email,
      shipping_address: shipping_and_billing_address_info,
      billing_address: shipping_and_billing_address_info,
      note: "Shoe size: #{current_user.shoe_size}, " \
            "clothing size: #{current_user.clothing_size}",
      financial_status: 'paid'
    )
  end

  def shipping_and_billing_address_info
    {
      address1: current_user.address,
      city: current_user.city,
      country: 'United States',
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      province: current_user.state_province_region,
      zip: current_user.zipcode,
      name: current_user.fullname
    }
  end
end
