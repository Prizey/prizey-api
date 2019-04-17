# frozen_string_literal: true

require 'rails_helper'

describe 'POST /auth/sign_in', type: :request do
  let(:user) { User.create(email: 'john@connor.com', password: '123456789') }
  let(:headers) { { 'Content-Type': 'application/json' } }
  let(:params) { {} }

  before do
    user
    post '/auth/sign_in', params: params.to_json
  end

  context 'with correct params' do
    let(:params) { { email: 'john@connor.com', password: '123456789' } }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq({ data: User.last }.to_json) }
    it { expect(response.has_header?('access-token')).to eq(true) }
  end

  context 'with wrong password' do
    let(:params) { { email: 'john@connor.com', password: 'wrong_password' } }

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response.has_header?('access-token')).to eq(false) }
    it {
      expect(response.body).to eq({
        success: false, errors: ['Invalid login credentials. Please try again.']
      }.to_json)
    }
  end

  context 'when email does not exist' do
    let(:params) { { email: 'bar@foo.com', password: 'wrong_password' } }

    it { expect(response).to have_http_status(:not_found) }
  end

  context 'with blocked user' do
    let(:user) do
      User.create(
        email: 'john@connor.com', password: '123456789', blocked: true
      )
    end

    let(:params) { { email: 'john@connor.com', password: '123456789' } }

    let(:msg_error) do
      {
        id: 'unauthorized',
        message: 'Your account is currently blocked, please, contact support.'
      }.to_json
    end

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response.has_header?('access-token')).to eq(false) }
    it { expect(response.body).to eq(msg_error) }
  end
end
