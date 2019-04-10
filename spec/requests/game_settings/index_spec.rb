# frozen_string_literal: true

require 'rails_helper'

describe 'GET /game_settings', type: :request do
  context 'with correct request' do
    subject { response.body }

    let(:game_settings) do
      create_list(:game_setting, 3)
    end

    let(:expected_body) do
      [
        {
          id: GameSetting.first.id,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        },
        {
          id: GameSetting.second.id,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        },
        {
          id: GameSetting.third.id,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        }
      ].to_json
    end

    before do
      game_settings
      get '/game_settings'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq(expected_body) }
    it { is_expected.to eq(expected_body) }
  end

  context 'with incorrect request' do
    before { get '/game_settings', params: { foo: 'bar' }, headers: nil }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
