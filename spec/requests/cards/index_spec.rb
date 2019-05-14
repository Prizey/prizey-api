# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /cards', type: :request do
  describe 'when user is logged in' do
    include_context 'with current_user'

    let(:customer_cards) do
      File.read('spec/support/fixtures/stripe_customer_cards.json')
        .squish
    end

    let(:empty_cards) do
      File.read('spec/support/fixtures/stripe_customer_empty_cards.json')
        .squish
    end

    let(:results) do
      [
        { 'brand' => 'Visa',
          'id' => 'card_1ETCjpAsgrkdX91pYQe4tpCZ',
          'last4' => '4242' },
        { 'brand' => 'MasterCard',
          'id' => 'card_1ETCjpAsgrkdX91pYQe4tpCY',
          'last4' => '4444' }
      ]
    end

    context 'with at least one card' do
      before do
        stub_request(:get, 'https://api.stripe.com/v1/customers/us_123/sources?object=card')
          .to_return(status: 200, body: customer_cards, headers: {})
        get '/cards'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)).to eq(results) }
      it { expect(JSON.parse(response.body)).not_to eq(results.reverse) }
    end

    context 'without any card' do
      before do
        stub_request(:get, 'https://api.stripe.com/v1/customers/us_123/sources?object=card')
          .to_return(status: 200, body: empty_cards, headers: {})
        get '/cards'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)).to eq([]) }
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
        get '/cards'
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    before do
      get '/cards'
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
