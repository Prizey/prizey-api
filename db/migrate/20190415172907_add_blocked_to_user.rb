# frozen_string_literal: true

class AddBlockedToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :blocked, default: false
    end
  end
end
