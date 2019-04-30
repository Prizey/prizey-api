# frozen_string_literal: true

class AddBalanceToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.integer :balance, default: 0
    end
  end
end
