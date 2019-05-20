# frozen_string_literal: true

class AddTermsOfServiceToGameSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :game_settings, :terms_of_service, :text
  end
end
