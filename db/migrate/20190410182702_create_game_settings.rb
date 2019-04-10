# frozen_string_literal: true

class CreateGameSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :game_settings do |t|
      t.integer :easy_carousel_speed, null: false, default: 1
      t.integer :medium_carousel_speed, null: false, default: 2
      t.integer :hard_carousel_speed, null: false, default: 3

      t.timestamps
    end
  end
end
