# frozen_string_literal: true

class AddGameBlockedToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :game_blocked, :boolean
  end
end
