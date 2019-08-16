# frozen_string_literal: true

require 'rails_helper'

describe 'POST /ticket_transactions', type: :request do
  let(:game_setting) do
    GameSetting.create!(
      price_multiplier: 0.0,
      easy_carousel_speed: 250,
      medium_carousel_speed: 180,
      hard_carousel_speed: 100,
      easy_ticket_amount: 1,
      medium_ticket_amount: 5,
      hard_ticket_amount: 10,
      game_blocked: false,
      starting_balance: 4,
      vast_tag: 'https://syndication.exdynsrv.com/splash.php?idzone=3459509',
      ad_diamonds_reward: 5,
      video_ads_for_reward: 2,
      sell_it_back_amount: 1
    )
  end

  describe 'when user is logged in and does have enough tickets' do
    include_context 'with current_user'

    context 'with correct params' do
      before do
        game_setting
        current_user.ticket_transactions.create(source: 'reward', amount: 1)
        post '/ticket_transactions', params: {
          source: 'play', difficulty: 'easy'
        }.to_json
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body)['amount']).to eq(-1) }
    end

    context 'when type is reward and less than 30s have passed' do
      let(:params) { { source: 'reward' }.to_json }

      before do
        game_setting
        Timecop.freeze(Time.zone.now)
        post '/ticket_transactions', params: params
        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(TicketTransaction.last.source).to eq('reward') }
    end

    context 'when type is reward and more than 30s have passed' do
      let(:params) { { source: 'reward' }.to_json }

      before do
        game_setting
        now = Time.zone.now
        Timecop.freeze(Time.zone.now)
        post '/ticket_transactions', params: params
        Timecop.travel(now + 31)
        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:created) }
      it do
        expect(TicketTransaction.last(2).pluck(:source))
          .to eq(%w[reward reward])
      end
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
        game_setting
        current_user.blocked = true
        post '/ticket_transactions', params: { source: 'sell' }.to_json
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged in but does not have enough tickets/balance' do
    include_context 'with current_user'

    context 'with correct params' do
      before do
        game_setting
        current_user.ticket_transactions.create!(
          source: 'reward',
          amount: -1 * current_user.tickets
        )
        post '/ticket_transactions',
          params: { source: 'play', difficulty: 'hard' }.to_json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(JSON.parse(response.body)['id']).to eq('error') }
      it {
        expect(JSON.parse(response.body)['message']).to eq(
          'You do not have enough Tickets'
        )
      }
    end

    context 'with incorrect params' do
      before do
        game_setting
        post '/ticket_transactions', params: { foo: 'bar' }.to_json
      end

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
        game_setting
        current_user.blocked = true
        post '/ticket_transactions', params: { source: 'reward' }.to_json
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    context 'with correct params' do
      before do
        game_setting
        post '/ticket_transactions', params: { source: 'reward' }.to_json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'with incorrect params' do
      before { post '/ticket_transactions', params: { foo: 'bar' }.to_json }

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'when source is sell' do
    include_context 'with current_user'
    let(:params) { { source: 'sell' }.to_json }

    context 'when the user last transaction was play' do
      before do
        game_setting
        current_user.ticket_transactions.create(source: 'reward', amount: 10)
        now = Time.zone.now
        Timecop.freeze(Time.zone.now)

        current_user.ticket_transactions.create(source: 'play', amount: -3)

        Timecop.travel(now + 31)

        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:created) }
    end

    context 'when the user last transaction was sell' do
      before do
        game_setting
        now = Time.zone.now
        Timecop.freeze(Time.zone.now)

        current_user.ticket_transactions.create(source: 'sell')

        Timecop.travel(now + 31)

        post '/ticket_transactions', params: params
      end

      after { Timecop.return }

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'when it is a non-expected source' do
    include_context 'with current_user'

    before do
      game_setting
      post '/ticket_transactions', params: { source: 'foo' }.to_json
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(JSON.parse(response.body)['amount']).to eq(0) }
  end
end
