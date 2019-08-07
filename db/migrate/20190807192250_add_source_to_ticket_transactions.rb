# frozen_string_literal: true

class AddSourceToTicketTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :ticket_transactions, :source, :string
  end
end
