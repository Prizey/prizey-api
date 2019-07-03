# frozen_string_literal: true

class RemoveUnusedTextsFromGameSettings < ActiveRecord::Migration[5.2]
  def up
    change_table :game_settings, bulk: true do |g|
      g.remove :homepage_cta
      g.remove :privacy_policy
      g.remove :terms_of_service
      g.remove :fairness_text
    end
  end

  def down
    change_table :game_settings, bulk: true do |g|
      g.string :homepage_cta, default: 'Play now for $3!'
      g.text :privacy_policy
      g.text :terms_of_service
      g.text :fairness_text
    end
  end
end
