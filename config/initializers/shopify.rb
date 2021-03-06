# frozen_string_literal: true

session = ShopifyAPI::Session.new(
  domain: ENV['SHOPIFY_NAME'],
  token: ENV['SHOPIFY_PASSWORD'],
  api_version: ENV['SHOPIFY_API_VERSION']
)

ShopifyAPI::Base.activate_session(session)
