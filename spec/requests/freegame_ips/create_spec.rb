# frozen_string_literal: true

require 'rails_helper'

describe 'POST /freegame_ips', type: :request do
  let(:params) { { ip: '127.0.0.1' }.to_json }

  context 'with correct params' do
    before do
      post '/freegame_ips', params: params
    end

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    before { post '/freegame_ips', params: { foo: 'bar' }.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
