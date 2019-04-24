# frozen_string_literal: true

class ShopifyCollection
  def self.find_by(attribute, param)
    collections = ShopifyAPI::CustomCollection.all.as_json
    collections.select! do |collection|
      collection[attribute.to_s] == param
    end
    raise ActiveRecord::RecordNotFound if collections.blank?
    collections.first
  end

  def self.products(collection_id)
    ShopifyAPI::CustomCollection
      .find(collection_id)
      .products
  end

  def self.serialize_products(products)
    JSON.parse(products.to_json).map do |product|
      { id: product['variants'][0]['id'],
        title: product['title'],
        image: product['image']['src'],
        price: product['variants'][0]['price'].to_f }
    end
  end
end
