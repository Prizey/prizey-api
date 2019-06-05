# frozen_string_literal: true

require 'rails_helper'

describe AddStartingBalance, type: :service do
  before do
    create(:game_setting, starting_balance: 5)
    stub_stripe_customer('john@doe.com')
  end

  let(:user) do
    User.skip_callback(:create, :after, :add_starting_balance)
    user = create(:user, email: 'john@doe.com')
    User.set_callback(:create, :after, :add_starting_balance)
    user
  end

  context 'when everything is successful' do
    it do
      expect { described_class.execute(user.id) }.to change(
        TicketTransaction, :count
      ).from(0).to(1)
    end

    it do
      expect { described_class.execute(user.id) }.to change(
        user, :tickets
      ).from(0).to(5)
    end

    it do
      described_class.execute(user.id)
      expect(TicketTransaction.last.user.id).to eq(user.id)
    end

    it do
      expect(described_class.execute(user.id)).to eq(
        success: true, payload: TicketTransaction.last
      )
    end
  end

  context 'when there is an error' do
    it do
      described_class.execute('wrong id')
      expect(TicketTransaction.count).to eq(0)
    end

    it do
      described_class.execute('wrong id')
      expect(user.tickets).to eq(0)
    end

    it do
      expect(described_class.execute('wrong id')).to eq(
        success: false, errors: ['User must exist']
      )
    end
  end
end
