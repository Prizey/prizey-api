# frozen_string_literal: true

class AddTicketsAmountsToGameSetting < ActiveRecord::Migration[5.2]
  def change
    change_table :game_settings, bulk: true do |t|
      t.integer :easy_ticket_amount, null: false, default: 1
      t.integer :medium_ticket_amount, null: false, default: 2
      t.integer :hard_ticket_amount, null: false, default: 3
    end
  end
end
