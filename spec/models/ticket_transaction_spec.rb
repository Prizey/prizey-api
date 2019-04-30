# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketTransaction, type: :model do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to belong_to :user }

  describe '#as_json' do
    let(:ticket_transaction) { create(:ticket_transaction) }

    let(:json) do
      {
        id: ticket_transaction.id,
        user: ticket_transaction.user.as_json,
        amount: ticket_transaction.amount,
        created_at: ticket_transaction.created_at
      }
    end

    it { expect(ticket_transaction.as_json).to eq(json) }
  end

  describe '#update_user_balance' do
    let(:user) { create(:user) }

    it do
      expect { TicketTransaction.create(user: user, amount: 10) }
        .to change(user, :balance).by(10)
    end
  end
end
