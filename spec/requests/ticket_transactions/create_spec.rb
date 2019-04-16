# frozen_string_literal: true

require 'rails_helper'

describe 'POST /ticket_transactions', type: :request do
  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with correct params' do
      before { post '/ticket_transactions', params: { amount: 10 }.to_json }

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body)['amount']).to eq(10) }
    end

    context 'with incorrect params' do
      before { post '/ticket_transactions', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'when user is logged out' do
    context 'with correct params' do
      before { post '/ticket_transactions', params: { amount: 10 }.to_json }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with incorrect params' do
      before { post '/ticket_transactions', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end
end
