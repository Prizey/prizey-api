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
      variant = product['variants'][0]
      next if variant['inventory_quantity'].zero?

      { id: variant['id'],
        title: product['title'],
        image: product['image']['src'],
        price: variant['price'].to_f }
    end.compact
  end

  def self.sort_products_by_tags(collection_identifier, products)
    JSON.parse(products.to_json).sort_by do |product|
      if product['tags'].is_a?(Array)
        collection_tag = (
          product['tags'].select { |tag| tag.start_with? collection_identifier }
        ).first
      end

      order = collection_tag&.split(':')&.last.to_i
      order.positive? ? order : 1_000_000
    end
  end
end
