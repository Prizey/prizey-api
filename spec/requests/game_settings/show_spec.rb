# frozen_string_literal: true

require 'rails_helper'

describe 'GET /game_setting/:id', type: :request do
  context 'with correct request' do
    subject { response.body }

    let(:game_setting) do
      create(:game_setting)
    end

    let(:id) { game_setting.id }
    let(:headers) { {} }
    let(:params) { {} }

    let(:expected_body) do
      {
        id: GameSetting.first.id,
        price_multiplier: 1,
        easy_carousel_speed: 1,
        medium_carousel_speed: 2,
        hard_carousel_speed: 3,
        easy_ticket_amount: 1,
        medium_ticket_amount: 2,
        hard_ticket_amount: 3
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
end
