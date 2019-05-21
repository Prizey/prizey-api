# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketTransaction, type: :model do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to belong_to :user }

  describe '#as_json' do
    let(:user) { create(:user) }
    let(:ticket_transaction) { create(:ticket_transaction, user: user) }

    let(:json) do
      {
        id: ticket_transaction.id,
        user: user.as_json,
        amount: ticket_transaction.amount,
        created_at: ticket_transaction.created_at
      }
    end

    before { stub_stripe_customer('user_1@example.com') }

    it { expect(ticket_transaction.as_json).to eq(json) }
  end

  describe 'Update triggers on database' do
    let(:user) { create(:user, email: 'foo@bar.com') }
    let(:user_2) { create(:user, email: 'foo_2@bar.com') }
    let(:ticket) { TicketTransaction.create(user: user, amount: 100) }
    let(:ticket_2) { TicketTransaction.create(user: user_2, amount: 100) }

    context 'when creating a new TicketTransaction' do
      before do
        stub_stripe_customer('foo@bar.com')
        stub_stripe_customer('foo_2@bar.com')
        ticket
        ticket_2
      end

      it do
        user.reload
        expect(user.balance).to eq(100)
      end
    end

    context 'when updating a new TicketTransaction' do
      before do
        stub_stripe_customer('foo@bar.com')
        stub_stripe_customer('foo_2@bar.com')
        ticket
        ticket_2
      end

      it do
        user.reload
        expect(user.balance).to eq(100)
      end

      it do
        ticket.update(amount: 50)
        user.reload
        expect(user.balance).to eq(50)
      end
    end

    context 'when destroying a new TicketTransaction' do
      before do
        stub_stripe_customer('foo@bar.com')
        stub_stripe_customer('foo_2@bar.com')
        ticket
        ticket_2
      end

      it do
        user.reload
        expect(user.balance).to eq(100)
      end

      it do
        ticket.destroy
        user.reload
        expect(user.balance).to eq(nil)
      end
    end
  end
end
