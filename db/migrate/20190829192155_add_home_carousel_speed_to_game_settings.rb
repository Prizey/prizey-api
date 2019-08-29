# frozen_string_literal: true

class AddHomeCarouselSpeedToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :home_carousel_speed, :integer, default: 1
  end
end
