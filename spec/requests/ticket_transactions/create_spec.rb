# frozen_string_literal: true

require 'rails_helper'

describe 'POST /ticket_transactions', type: :request do
  describe 'when user is logged in and does have enough tickets' do
    include_context 'with current_user'

    context 'with correct params' do
      before { post '/ticket_transactions', params: { amount: 10 }.to_json }

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body)['amount']).to eq(10) }
    end

    context 'when type is reward and less than 30s have passed' do
      let(:params) { { amount: 12, source: 'reward' }.to_json }

      before do
        Timecop.freeze(Time.zone.now)
        post '/ticket_transactions', params: params
        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(TicketTransaction.where(amount: 12).count).to eq(1) }
    end

    context 'when type is reward and more than 30s have passed' do
      let(:params) { { amount: 12, source: 'reward' }.to_json }

      before do
        now = Time.zone.now
        Timecop.freeze(Time.zone.now)
        post '/ticket_transactions', params: params
        Timecop.travel(now + 31)
        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:created) }
      it { expect(TicketTransaction.where(amount: 12).count).to eq(2) }
    end

    context 'with incorrect params' do
      before { post '/ticket_transactions', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
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
        post '/ticket_transactions', params: { amount: 10 }.to_json
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged in but does not have enough tickets/balance' do
    include_context 'with current_user'

    context 'with correct params' do
      before { post '/ticket_transactions', params: { amount: -100 }.to_json }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(JSON.parse(response.body)['id']).to eq('error') }
      it {
        expect(JSON.parse(response.body)['message']).to eq(
          'You do not have enough Tickets'
        )
      }
    end

    context 'with incorrect params' do
      before { post '/ticket_transactions', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
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
        post '/ticket_transactions', params: { amount: 10 }.to_json
      end

      it { expect(response).to have_http_status(:forbidden) }
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
