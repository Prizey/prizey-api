# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    collection = ShopifyCollection.find_by(:handle, params[:identifier])
    products = ShopifyCollection.products(collection['id'])
    serialized = ShopifyCollection.serialize_products(products)
    render json: serialized, status: :ok
  end
end
