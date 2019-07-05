# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /purchase_options', type: :request do
  describe 'when user is logged in' do
    include_context 'with current_user'

    context 'with purchase options, last 3 records & ordered' do
      let(:pack_1) { create(:purchase_option, :pack_1) }
      let(:pack_2) { create(:purchase_option, :pack_2) }
      let(:pack_3) { create(:purchase_option, :pack_3) }

      let(:results) do
        JSON.parse([
          pack_1.as_json,
          pack_2.as_json
        ].to_json)
      end

      before do
        3.times { pack_1 }
        pack_2
        pack_3
        get '/purchase_options'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body).length).to eq(2) }
      it { expect(JSON.parse(response.body)).to eq(results) }
    end

    context 'without purchase options' do
      before do
        get '/purchase_options'
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)).to eq([]) }
    end

    context 'with blocked user' do
      let(:msg_error) do
        {
          id: 'forbidden',
          message: 'Your account is currently blocked, please, contact support.'
        }.to_json
      end

      before do
        current_user.blocked = true
        get '/purchase_options'
      end

      it { expect(response).to have_http_status(:forbidden) }
      it { expect(response.has_header?('access-token')).to eq(false) }
      it { expect(response.body).to eq(msg_error) }
    end
  end

  describe 'when user is logged out' do
    before do
      get '/purchase_options'
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
