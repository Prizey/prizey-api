# frozen_string_literal: true

require 'rails_helper'

describe 'POST /orders', type: :request do
  before do
    stub_request(:post, 'https://prizeyapp.myshopify.com/admin/api/2019-04/draft_orders.json')
      .with(
        body: {
          draft_order: {
            line_items: [{ variant_id: '123', quantity: 1 }],
            customer: { id: nil },
            use_customer_default_address: true,
            financial_status: 'paid'
          }
        }.to_json
      ).to_return(status: 200, body: { status: 'open' }.to_json, headers: {})

    stub_request(:post, 'https://prizeyapp.myshopify.com/admin/api/2019-04/draft_orders.json')
      .with(
        body: {
          draft_order: {
            line_items: [{ variant_id: 'bar', quantity: 1 }],
            customer: { id: nil },
            use_customer_default_address: true,
            financial_status: 'paid'
          }
        }.to_json
      ).to_return(status: 200, body: { status: 'fail' }.to_json, headers: {})
  end

  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with correct params' do
      before { post '/orders', params: { product_id: '123' }.to_json }

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body)['id']).to eq('success') }
    end

    context 'with invalid product_id' do
      before { post '/orders', params: { product_id: 'bar' }.to_json }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(JSON.parse(response.body)['id']).to eq('error') }
    end

    context 'with incorrect params' do
      before { post '/orders', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'when user is logged out' do
    context 'with correct params' do
      before { post '/orders', params: { product_id: '123' }.to_json }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with incorrect params' do
      before { post '/orders', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end
end
