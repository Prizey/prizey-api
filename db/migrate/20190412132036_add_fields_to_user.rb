# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[5.2]
  change_table :users, bulk: true do |t|
    t.string :fullname
    t.string :address
    t.string :city
    t.string :state_province_region
    t.string :postal_code_zip
    t.string :clothing_size
    t.string :shoe_size
  end
end
