# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /auth', type: :request do
  include_context 'with current_user'

  let(:params) { {} }
  let(:stubs) do
    stub_stripe_customer

    stub_request(:post, 'https://api.stripe.com/v1/customers/us_123').with(
      body: {
        'address' => {
          'line1' => 'Some Address',
          'city' => 'Some City',
          'country' => 'USA',
          'postal_code' => 'Some Zipcode',
          'state' => 'Some State'
        },
        'name' => 'John Connor'
      }
    ).to_return(status: 200, body: {}.to_json, headers: {})

    stub_request(:post, 'https://api.stripe.com/v1/customers/us_123').with(
      body: {
        'address' => {
          'line1' => 'foo bar',
          'city' => 'foobar',
          'country' => 'USA',
          'postal_code' => 'foobar',
          'state' => 'foobar'
        },
        'name' => 'JohnConnor'
      }
    ).to_return(status: 200, body: {}.to_json, headers: {})
  end

  before do
    stubs
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
        zipcode: 'Some Zipcode',
        clothing_size: 'Some Clothing Size',
        shoe_size: 'Some Shoe Size'
      }
    end

    let(:reloaded_user) { current_user.reload }

    it { expect(response).to have_http_status(:ok) }
    it { expect(reloaded_user.fullname).to eq('John Connor') }
    it { expect(reloaded_user.address).to eq('Some Address') }
    it { expect(reloaded_user.city).to eq('Some City') }
    it { expect(reloaded_user.state_province_region).to eq('Some State') }
    it { expect(reloaded_user.zipcode).to eq('Some Zipcode') }
    it { expect(reloaded_user.clothing_size).to eq('Some Clothing Size') }
    it { expect(reloaded_user.shoe_size).to eq('Some Shoe Size') }
    it { expect(reloaded_user.blocked).to eq(false) }
    it {
      expect(response.body).to eq(
        { status: 'success', data: current_user.reload }.to_json
      )
    }
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
