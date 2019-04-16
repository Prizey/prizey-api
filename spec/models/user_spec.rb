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
        tickets: 20
      }
    end

    it do
      tickets
      expect(user.as_json).to eq(json)
    end
  end
end
