# frozen_string_literal: true

class AddFairnessTextToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :fairness_text, :text
  end
end
