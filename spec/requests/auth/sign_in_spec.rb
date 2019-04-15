# frozen_string_literal: true

require 'rails_helper'

describe 'POST /auth/sign_in', type: :request do
  let(:user) do
    User.create(
      email: 'john.connor@email.com',
      password: '123456789'
    )
  end

  let(:headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  let(:params) { {} }

  before do
    user
    post '/auth/sign_in', params: params.to_json
  end

  context 'with correct params' do
    let(:params) do
      {
        email: 'john.connor@email.com',
        password: '123456789'
      }
    end

    it { expect(response).to have_http_status(:ok) }

    it 'returns correct body' do
      expect(response.body).to eq({ data: User.last }.to_json)
    end

    it 'returns access token header' do
      expect(response.has_header?('access-token')).to eq(true)
    end
  end

  context 'with wrong password' do
    let(:params) do
      {
        email: 'john.connor@email.com',
        password: 'wrong_password'
      }
    end

    it { expect(response).to have_http_status(:unauthorized) }

    it 'returns success:false and errors' do
      expect(response.body).to eq({
        success: false,
        errors: [I18n.t('devise_token_auth.sessions.bad_credentials')]
      }.to_json)
    end

    it 'does not return access token header' do
      expect(response.has_header?('access-token')).to eq(false)
    end

    it {
      expect(I18n.t('devise_token_auth.sessions.bad_credentials'))
        .to eq('Invalid login credentials. Please try again.')
    }
  end

  context 'when email does not exist' do
    let(:params) do
      {
        email: 'bar@foo.com',
        password: 'wrong_password'
      }
    end

    it { expect(response).to have_http_status(:not_found) }
  end
end
