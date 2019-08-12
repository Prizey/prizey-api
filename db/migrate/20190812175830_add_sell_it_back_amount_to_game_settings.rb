# frozen_string_literal: true

class AddSellItBackAmountToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :sell_it_back_amount, :integer, default: 3
  end
end
