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

    context 'with blocked user' do
      let(:msg_error) do
        {
          id: 'unauthorized',
          message: 'Your account is currently blocked, please, contact support.'
        }.to_json
      end

      before do
        current_user.blocked = true
        post '/ticket_transactions', params: { amount: 10 }.to_json
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
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
