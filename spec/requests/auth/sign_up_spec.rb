# frozen_string_literal: true

require 'rails_helper'

describe 'POST /auth - Sign Up', type: :request do
  let(:user) do
    {
      email: 'john.connor@email.com',
      password: '123456789'
    }
  end

  let(:headers) { {} }

  let(:params) { {} }

  let(:expected_hash) do
    {
      id: User.last.id,
      email: 'john.connor@email.com',
      fullname: nil,
      address: nil,
      city: nil,
      state_province_region: nil,
      zipcode: nil,
      clothing_size: nil,
      shoe_size: nil,
      tickets: 0
    }
  end

  context 'with valid email' do
    before do
      post '/auth', params: params.to_json
    end

    let(:params) { user }

    it { expect(response).to have_http_status(:ok) }
    it { expect(User.count).to eq(2) }

    it 'returns the created user' do
      expect(response.body).to eq({
        status: 'success',
        data: expected_hash
      }.to_json)
    end
  end

  context 'when the email is already taken' do
    before do
      User.create!(user)
      post '/auth', params: params.to_json
    end

    let(:params) { user }

    it { expect(response).to have_http_status(:unprocessable_entity) }

    it 'returns error with correct messages' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({
        status: 'error',
        data: expected_hash.merge(id: nil),
        errors: message_error
      }.to_json))
    end

    it 'does NOT return access token header' do
      expect(response.has_header?('access-token')).to eq(false)
    end
  end

  def message_error
    {
      email: ['has already been taken'],
      full_messages: ['Email has already been taken']
    }
  end
end
