# frozen_string_literal: true

class AddStartingBalanceToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :starting_balance, :integer, default: 0
  end
end
