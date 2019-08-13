# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    collection = ShopifyCollection.find_by(:handle, params[:identifier])
    products = ShopifyCollection.products(collection['id'])
    sorted = ShopifyCollection.sort_products_by_tags(
      params[:identifier], products
    )
    serialized = ShopifyCollection.serialize_products(sorted)
    render json: serialized, status: :ok
  end
end
