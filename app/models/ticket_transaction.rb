# frozen_string_literal: true

class TicketTransaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true

  after_create :update_user_balance

  def as_json(_options = {})
    {
      id: id,
      user: user.as_json,
      amount: amount,
      created_at: created_at
    }
  end

  private

  def update_user_balance
    user.update(balance: user.tickets)
  end
end
