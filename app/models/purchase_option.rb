# frozen_string_literal: true

class PurchaseOption < ApplicationRecord
  validates :name, :price, :ticket_amount, presence: true

  def as_json(_options = {})
    {
      id: id,
      name: name,
      price: price.to_i,
      ticket_amount: ticket_amount
    }
  end
end
