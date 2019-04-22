# frozen_string_literal: true

require 'rails_helper'

describe 'GET /ticket_transactions', type: :request do
  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with ticket_transactions' do
      let(:ticket_transactions) do
        create_list(:ticket_transaction, 5, user: current_user)
      end

      before do
        ticket_transactions
        get '/ticket_transactions'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body).count).to eq(5) }
    end

    context 'without ticket_transactions' do
      before do
        get '/ticket_transactions'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)).to eq([]) }
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
        get '/ticket_transactions'
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    before do
      get '/ticket_transactions'
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
