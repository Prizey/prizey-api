# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    collection = ShopifyCollection.find_by(:handle, params[:identifier])
    products = ShopifyCollection.products(collection['id'])
    serialized = ShopifyCollection.serialize_products(products)
    sorted = serialized.sort_by! { |product| product[:price] }
    render json: sorted, status: :ok
  end
end
