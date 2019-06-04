# frozen_string_literal: true

class TicketTransaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true

  def as_json(_options = {})
    {
      id: id,
      user: user.as_json,
      amount: amount
    }
  end
end
