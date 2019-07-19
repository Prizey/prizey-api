# frozen_string_literal: true

class AddNumberOfVideosToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :video_ads_for_reward, :integer, default: 1
  end
end
