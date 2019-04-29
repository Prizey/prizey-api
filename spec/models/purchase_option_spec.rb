# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchaseOption, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_presence_of :ticket_amount }

  describe '#as_json' do
    let(:purchase_option) { create(:purchase_option, :pack_1) }

    let(:json) do
      {
        id: purchase_option.id,
        name: 'pack_1',
        price: 10,
        ticket_amount: 10
      }
    end

    it { expect(purchase_option.as_json).to eq(json) }
  end
end
