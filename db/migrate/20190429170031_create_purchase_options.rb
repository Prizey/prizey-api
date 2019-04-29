# frozen_string_literal: true

class CreatePurchaseOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_options do |t|
      t.string :name, null: false, default: ''
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.integer :ticket_amount, null: false, default: 0

      t.timestamps
    end
  end
end
