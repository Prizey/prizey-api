# frozen_string_literal: true

class AddPrivacyPolicyToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :privacy_policy, :text
  end
end
