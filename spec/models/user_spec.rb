# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#as_json' do
    let(:user) { create(:user) }
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
    let(:user) { create(:user) }

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
end
