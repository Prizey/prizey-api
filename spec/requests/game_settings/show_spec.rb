# frozen_string_literal: true

require 'rails_helper'

describe 'GET /game_setting/:id', type: :request do
  let(:game_setting) do
    create(:game_setting)
  end

  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with correct request' do
      subject { response.body }

      let(:id) { game_setting.id }
      let(:headers) { {} }
      let(:params) { {} }

      let(:expected_body) do
        {
          id: GameSetting.first.id,
          price_multiplier: 0.5,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3,
          easy_ticket_amount: 1,
          medium_ticket_amount: 2,
          hard_ticket_amount: 3,
          ad_diamonds_reward: 3,
          vast_tag: 'abc123',
          video_ads_for_reward: 1
        }.to_json
      end

      before do
        game_setting
        get '/game_setting', params: params
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to eq(expected_body) }
      it { is_expected.to eq(expected_body) }
    end

    context 'with incorrect request' do
      before { get '/game_setting', params: { foo: 'bar' }, headers: nil }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with blocked user' do
      include_context 'with current_user'

      let(:msg_error) do
        {
          id: 'forbidden',
          message: 'Your account is currently blocked, please, contact support.'
        }.to_json
      end

      before do
        current_user.blocked = true
        get '/game_setting'
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    before do
      game_setting
      get '/game_setting'
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
