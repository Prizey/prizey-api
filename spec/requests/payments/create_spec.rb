# frozen_string_literal: true

require 'rails_helper'

describe 'POST /payments', type: :request do
  let(:stripe_error_body) do
    { 'amount' => '1000',
      'currency' => 'usd',
      'source' => 'some_invalid_token',
      'customer' => current_user.stripe_customer_id,
      'description' => "10 Tickets for User #{current_user.email}" }
  end

  let(:stripe_success_response_body) do
    { id: '12345',
      status: 'succeeded',
      paid: true }.to_json
  end

  let(:stripe_failed_response_body) do
    { id: '12345',
      status: 'card_error',
      paid: true }.to_json
  end

  let(:failed_stripe_request) do
    stub_request(:post, 'https://api.stripe.com/v1/charges').with(
      body: stripe_error_body
    ).to_return(status: 200, body: stripe_failed_response_body, headers: {})
  end

  let(:pack_1) { create(:purchase_option, :pack_1) }
  let(:pack_2) { create(:purchase_option, :pack_2) }
  let(:pack_3) { create(:purchase_option, :pack_3) }

  describe 'when user is logged in' do
    include_context 'with current_user'

    describe 'with a new credit card' do
      # rubocop:disable RSpec/NestedGroups
      context 'when pack_1 is selected' do
        before do
          pack_1
          stub_new_credit_card('card_abc123')
          success_stripe_request('1000', '10')
          post '/payments', params: {
            purchase_option_id: PurchaseOption.find_by(name: 'pack_1').id.to_s,
            credit_card_token: 'card_abc123'
          }.to_json
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(JSON.parse(response.body)['id']).to eq('success') }
      end

      context 'when pack_2 is selected' do
        before do
          pack_2
          stub_new_credit_card('card_abc123')
          success_stripe_request('2500', '25')
          post '/payments', params: {
            purchase_option_id: PurchaseOption.find_by(name: 'pack_2').id.to_s,
            credit_card_token: 'card_abc123'
          }.to_json
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(JSON.parse(response.body)['id']).to eq('success') }
      end

      context 'when pack_3 is selected' do
        before do
          pack_3
          stub_new_credit_card('card_abc123')
          success_stripe_request('5000', '50')
          post '/payments', params: {
            purchase_option_id: PurchaseOption.find_by(name: 'pack_3').id.to_s,
            credit_card_token: 'card_abc123'
          }.to_json
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(JSON.parse(response.body)['id']).to eq('success') }
      end
      # rubocop:enable RSpec/NestedGroups
    end

    context 'with an already created card' do
      before do
        pack_3
        stub_new_credit_card('card_abc123')
        success_stripe_request('5000', '50')
        post '/payments', params: {
          purchase_option_id: PurchaseOption.find_by(name: 'pack_3').id.to_s,
          credit_card_source: 'card_abc123'
        }.to_json
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body)['id']).to eq('success') }
    end

    context 'with incorrect params for payment' do
      before do
        pack_1
        stub_new_credit_card('some_invalid_token')
        failed_stripe_request
        post '/payments', params: {
          purchase_option_id: PurchaseOption.find_by(name: 'pack_1').id.to_s,
          credit_card_token: 'some_invalid_token'
        }.to_json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(JSON.parse(response.body)['id']).to eq('error') }
    end

    context 'with blocked user' do
      let(:msg_error) do
        {
          id: 'unauthorized',
          message: 'Your account is currently blocked, please, contact support.'
        }.to_json
      end

      before do
        pack_1
        success_stripe_request('1000', '10')
        current_user.blocked = true
        post '/payments', params: {
          purchase_option_id: PurchaseOption.find_by(name: 'pack_1').id.to_s,
          credit_card_token: 'abc'
        }.to_json
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    context 'with correct params' do
      before do
        pack_1
        success_stripe_request('1000', '10')
        post '/payments', params: {
          purchase_option_id: PurchaseOption.find_by(name: 'pack_1').id.to_s,
          credit_card_token: 'abc'
        }.to_json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with incorrect params' do
      before { post '/payments', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  def success_stripe_request(amount, tickets)
    stub_request(:post, 'https://api.stripe.com/v1/charges').with(
      body: stripe_success_body(amount, tickets)
    ).to_return(status: 200, body: stripe_success_response_body, headers: {})
  end

  def stub_new_credit_card(token)
    stub_request(:post, 'https://api.stripe.com/v1/customers/us_123/sources').with(
      body: { 'source' => token }
    ).to_return(status: 200, body: { id: token }.to_json, headers: {})
  end

  def stripe_success_body(amount, tickets)
    { 'amount' => amount,
      'currency' => 'usd',
      'source' => 'card_abc123',
      'customer' => 'us_123',
      'description' => "#{tickets} Tickets for User current.user@email.com" }
  end
end
