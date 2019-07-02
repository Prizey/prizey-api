# frozen_string_literal: true

require 'rails_helper'

describe 'GET /admin_texts', type: :request do
  let(:admin_text) do
    AdminText.create!(
      field: 'terms_of_use',
      text: 'foobar'
    )
  end

  let(:params) { { tags: ['terms_of_use'] } }
  let(:headers) { { 'Content-Type': 'application/json' } }

  context 'with text found' do
    before do
      admin_text
      get '/admin_texts', headers: headers, params: params
    end

    it { expect(response).to have_http_status(:ok) }

    it 'returns correct json' do
      expect(JSON.parse(response.body)).to eq(
        JSON.parse([{ "terms_of_use": 'foobar' }].to_json)
      )
    end
  end

  context 'with text not found' do
    before do
      get '/admin_texts', headers: headers, params: params
    end

    it { expect(response).to have_http_status(:ok) }

    it 'returns correct json' do
      expect(JSON.parse(response.body)).to eq(
        JSON.parse([{ "terms_of_use": nil }].to_json)
      )
    end
  end

  context 'with unpermitted parameters' do
    let(:params) { { project: { foo: 'bar' } } }

    before do
      get '/admin_texts', params: params.to_json, headers: headers
    end

    it 'returns bad request' do
      expect(response).to have_http_status(:bad_request)
    end
  end
end
