# frozen_string_literal: true

require 'rails_helper'

describe 'POST /freegame_ips', type: :request do
  context 'with correct params' do
    before do
      post '/freegame_ips'
    end

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    before { post '/freegame_ips', params: { foo: 'bar' }.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
