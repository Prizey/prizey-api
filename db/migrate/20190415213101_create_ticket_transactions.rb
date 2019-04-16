# frozen_string_literal: true

class CreateTicketTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_transactions do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
