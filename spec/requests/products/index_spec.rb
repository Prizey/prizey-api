# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /products/:identifier', type: :request do
  describe 'when identifier is found' do
    let(:collection) do
      ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
    end

    let(:collections) do
      File.read(
        'spec/support/fixtures/collections_success_response.json'
      ).squish
    end

    let(:products) do
      File.read(
        'spec/support/fixtures/products_success_response.json'
      ).squish
    end

    let(:results) do
      [{ 'id' => 123,
         'title' => 'Red Sock',
         'image' => 'https://cdn.shopify.com/products/REDSOCKS.png?v=15546629',
         'price' => '8.00' }]
    end

    before do
      stub_request(:get, api_url + '/custom_collections.json')
        .to_return(status: 200, body: collections, headers: {})

      allow(ShopifyAPI::CustomCollection).to receive(:all)
        .and_return([collection])
      allow(ShopifyAPI::CustomCollection).to receive(:find)
        .with(123).and_return(collection)
      allow(collection).to receive(:products).and_return(JSON.parse(products))

      get '/products/easy'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)).to eq(results) }
  end

  describe 'when identifier is found but have no products' do
    let(:collection) do
      ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
    end

    let(:collections) do
      File.read(
        'spec/support/fixtures/collections_success_response.json'
      ).squish
    end

    before do
      stub_request(:get, api_url + '/custom_collections.json')
        .to_return(status: 200, body: collections, headers: {})

      allow(ShopifyAPI::CustomCollection).to receive(:all)
        .and_return([collection])
      allow(ShopifyAPI::CustomCollection).to receive(:find)
        .with(123).and_return(collection)
      allow(collection).to receive(:products).and_return(JSON.parse('[]'))

      get '/products/easy'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)).to eq([]) }
  end

  describe 'when identifier is not found' do
    before do
      stub_request(:get, api_url + '/custom_collections.json')
        .to_return(status: 200, body: '[]', headers: {})
      get '/products/not_found'
    end

    it { expect(response).to have_http_status(:not_found) }
    it { expect(JSON.parse(response.body)['id']).to eq('not_found') }
  end

  def api_url
    'https://prizeyapp.myshopify.com/admin/api/2019-04'
  end
end
