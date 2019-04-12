# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /auth', type: :request do
  let(:params) { {} }

  before do
    put '/auth', params: params.to_json
  end

  context 'without params' do
    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context 'with correct params' do
    let(:params) do
      {
        fullname: 'John Connor',
        address: 'Some Address',
        city: 'Some City',
        state_province_region: 'Some State',
        postal_code_zip: 'Some Postal Code or Zip',
        clothing_size: 'Some Clothing Size',
        shoe_size: 'Some Shoe Size'
      }
    end

    let(:reloaded_user) { current_user.reload }

    it { expect(response).to have_http_status(:ok) }

    it 'updates the user fullname' do
      expect(reloaded_user.fullname).to eq('John Connor')
    end

    it 'updates the user address' do
      expect(reloaded_user.address).to eq('Some Address')
    end

    it 'updates the user city' do
      expect(reloaded_user.city).to eq('Some City')
    end

    it 'updates the user state province region' do
      expect(reloaded_user.state_province_region)
        .to eq('Some State')
    end

    it 'updates the user postal code or zip' do
      expect(reloaded_user.postal_code_zip).to eq('Some Postal Code or Zip')
    end

    it 'updates the user clothing size' do
      expect(reloaded_user.clothing_size).to eq('Some Clothing Size')
    end

    it 'updates the user shoe size' do
      expect(reloaded_user.shoe_size).to eq('Some Shoe Size')
    end

    it 'returns the updated user' do
      expect(response.body).to eq({
        status: 'success',
        data: current_user.reload
      }.to_json)
    end
  end

  context 'with just fullname' do
    let(:params) do
      {
        fullname: 'JohnConnor'
      }
    end

    let(:reloaded_user) { current_user.reload }

    it { expect(response).to have_http_status(:ok) }

    it 'updates the user fullname' do
      expect(reloaded_user.fullname).to eq('JohnConnor')
    end

    it 'returns the updated user' do
      expect(response.body).to eq({
        status: 'success',
        data: current_user.reload
      }.to_json)
    end
  end
end
