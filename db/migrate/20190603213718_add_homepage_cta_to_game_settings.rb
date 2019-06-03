# frozen_string_literal: true

class AddHomepageCtaToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :homepage_cta, :string,
      default: 'Play now for $3!'
  end
end
