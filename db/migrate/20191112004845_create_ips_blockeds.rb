# frozen_string_literal: true

class CreateIpsBlockeds < ActiveRecord::Migration[5.2]
  def change
    create_table :ips_blockeds do |t|
      t.string :user_ip

      t.timestamps
    end
  end
end
