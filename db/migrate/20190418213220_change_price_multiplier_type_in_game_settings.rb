# frozen_string_literal: true

class ChangePriceMultiplierTypeInGameSettings < ActiveRecord::Migration[5.2]
  def change
    change_column :game_settings, :price_multiplier, :float
  end
end
