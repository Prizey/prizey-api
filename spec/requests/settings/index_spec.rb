# frozen_string_literal: true

require 'rails_helper'

describe 'GET /settings', type: :request do
  context 'with correct request' do
    subject { response.body }

    let(:settings) do
      create_list(:setting, 3)
    end

    let(:expected_body) do
      [
        {
          id: Setting.first.id,
          easy_tickets: 1,
          medium_tickets: 2,
          hard_tickets: 3,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        },
        {
          id: Setting.second.id,
          easy_tickets: 1,
          medium_tickets: 2,
          hard_tickets: 3,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        },
        {
          id: Setting.third.id,
          easy_tickets: 1,
          medium_tickets: 2,
          hard_tickets: 3,
          easy_carousel_speed: 1,
          medium_carousel_speed: 2,
          hard_carousel_speed: 3
        }
      ].to_json
    end

    before do
      settings
      get '/settings'
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq(expected_body) }
    it { is_expected.to eq(expected_body) }
  end

  context 'with incorrect request' do
    before { get '/settings', params: { foo: 'bar' }, headers: nil }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
