# frozen_string_literal: true

class AddVastFieldsToGameSettings < ActiveRecord::Migration[5.2]
  def change
    change_table :game_settings, bulk: true do |t|
      t.string :vast_tag
      t.integer :ad_diamonds_reward
    end
  end
end
