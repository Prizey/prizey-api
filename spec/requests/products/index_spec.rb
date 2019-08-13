# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /products/:identifier', type: :request do
  let(:api_url) { 'https://prizeyapp.myshopify.com/admin/api/2019-04' }

  let(:collections) do
    File.read('spec/support/fixtures/collections_success_response.json')
      .squish
  end

  let(:products) do
    File.read('spec/support/fixtures/products_success_response.json').squish
  end

  let(:results) do
    [
      {
        'id' => 789,
        'title' => 'Blue Sock',
        'image' => 'https://cdn.shopify.com/products/BLUESOCKS.png?v=15546629',
        'price' => 9.9
      },
      {
        'id' => 123,
        'title' => 'Red Sock',
        'image' => 'https://cdn.shopify.com/products/REDSOCKS.png?v=15546629',
        'price' => 7.9
      },
      {
        'id' => 456,
        'title' => 'Yellow Sock',
        'image' => 'https://cdn.shopify.com/products/YELLOWSOCKS.png?v=15546629',
        'price' => 8.0
      }
    ]
  end

  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with identifier found' do
      let(:collection) do
        ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
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
      it { expect(JSON.parse(response.body)).not_to eq(results.reverse) }
    end

    context 'with the identifier found but without products' do
      let(:collection) do
        ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
      end

      let(:collections) do
        File.read('spec/support/fixtures/collections_success_response.json')
          .squish
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

    context 'with identifier not found' do
      before do
        stub_request(:get, api_url + '/custom_collections.json')
          .to_return(status: 200, body: '[]', headers: {})
        get '/products/not_found'
      end

      it { expect(response).to have_http_status(:not_found) }
      it { expect(JSON.parse(response.body)['id']).to eq('not_found') }
    end

    context 'with blocked user' do
      let(:msg_error) do
        {
          id: 'forbidden',
          message: 'Your account is currently blocked, please, contact support.'
        }.to_json
      end

      before do
        current_user.blocked = true
        get '/products/easy'
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    context 'with identifier found' do
      let(:collection) do
        ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
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
      it { expect(JSON.parse(response.body)).not_to eq(results.reverse) }
    end

    context 'with the identifier found but without products' do
      let(:collection) do
        ShopifyAPI::CustomCollection.new(id: 123, handle: 'easy')
      end

      let(:collections) do
        File.read('spec/support/fixtures/collections_success_response.json')
          .squish
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

    context 'with identifier not found' do
      before do
        stub_request(:get, api_url + '/custom_collections.json')
          .to_return(status: 200, body: '[]', headers: {})
        get '/products/not_found'
      end

      it { expect(response).to have_http_status(:not_found) }
      it { expect(JSON.parse(response.body)['id']).to eq('not_found') }
    end
  end
end
