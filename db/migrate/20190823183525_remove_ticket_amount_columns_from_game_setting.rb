# frozen_string_literal: true

class RemoveTicketAmountColumnsFromGameSetting < ActiveRecord::Migration[5.2]
  def up
    change_table :game_settings, bulk: true do |t|
      t.remove :easy_ticket_amount
      t.remove :medium_ticket_amount
      t.remove :hard_ticket_amount
    end
  end

  def down
    change_table :game_settings, bulk: true do |t|
      t.integer :easy_ticket_amount, null: false, default: 1
      t.integer :medium_ticket_amount, null: false, default: 2
      t.integer :hard_ticket_amount, null: false, default: 3
    end
  end
end
