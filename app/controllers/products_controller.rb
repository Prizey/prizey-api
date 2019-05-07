# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, if: :homepage?

  def index
    collection = ShopifyCollection.find_by(:handle, params[:identifier])
    products = ShopifyCollection.products(collection['id'])
    serialized = ShopifyCollection.serialize_products(products)
    sorted = serialized.sort_by! { |product| product[:price] }
    render json: sorted, status: :ok
  end

  def homepage?
    return true if params[:identifier] == 'homepage'
  end
end
