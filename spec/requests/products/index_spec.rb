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

  describe 'when the identifier is found but has no products' do
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

  describe 'when current user is blocked' do
    include_context 'with current_user'

    let(:msg_error) do
      {
        id: 'unauthorized',
        message: 'Your account is currently blocked, please, contact support.'
      }.to_json
    end

    before do
      current_user.blocked = true
      get '/products/easy'
    end

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response.has_header?('access-token')).to eq(false) }
    it { expect(response.body).to eq(msg_error) }
  end

  def api_url
    'https://prizeyapp.myshopify.com/admin/api/2019-04'
  end
end
