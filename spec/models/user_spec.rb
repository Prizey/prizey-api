# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: 'user_1@example.com') }

  before { stub_stripe_customer('user_1@example.com') }

  describe '#as_json' do
    let(:tickets) { create_list(:ticket_transaction, 2, user: user) }
    let(:json) do
      {
        id: user.id,
        email: user.email,
        fullname: user.fullname,
        address: user.address,
        city: user.city,
        state_province_region: user.state_province_region,
        zipcode: user.zipcode,
        clothing_size: user.clothing_size,
        shoe_size: user.shoe_size,
        blocked: user.blocked,
        tickets: 20
      }
    end

    it 'return the correct json format' do
      tickets
      expect(user.as_json).to eq(json)
    end
  end

  describe '#tickets' do
    context 'when there is not ticket_transactions' do
      it { expect(user.tickets).to eq(0) }
    end

    context 'when amount is positive' do
      before do
        create_list(:ticket_transaction, 2, user: user, amount: 10)
      end

      it { expect(user.tickets).to eq(20) }
    end

    context 'when amount is negative' do
      before do
        create_list(:ticket_transaction, 2, user: user, amount: -10)
      end

      it { expect(user.tickets).to eq(-20) }
    end
  end

  describe '#update_stripe_info' do
    context 'when calling stripe to update info' do
      before do
        stub_request(:post, 'https://api.stripe.com/v1/customers/us_123')
          .with(
            body: {
              'address' => {
                'line1' => 'updated address',
                'city' => 'foobar',
                'country' => 'USA',
                'postal_code' => 'foobar',
                'state' => 'foobar'
              },
              'name' => 'foo bar'
            }
          ).to_return(status: 200, body: {}.to_json, headers: {})
        user.update(address: 'updated address')
      end

      it do
        expect(user.address).to eq('updated address')
      end

      it do
        expect(user.fullname).not_to eq('some other name')
      end
    end

    context 'when not calling stripe to update info' do
      before do
        user.update(clothing_size: 'updated clothing_size')
      end

      it do
        expect(user.address).not_to eq('updated address')
      end

      it do
        expect(user.clothing_size).to eq('updated clothing_size')
      end
    end
  end
end
