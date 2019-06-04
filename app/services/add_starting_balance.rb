# frozen_string_literal: true

class AddStartingBalance
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize(user_id)
    @user = User.find_by(id: user_id)
    @amount = GameSetting.first.starting_balance
  end

  def execute
    ticket_transaction = TicketTransaction.new(user: @user, amount: @amount)
    if ticket_transaction.save
      { success: true, payload: ticket_transaction.as_json }
    else
      { success: false, errors: ticket_transaction.errors.full_messages }
    end
  end
end
