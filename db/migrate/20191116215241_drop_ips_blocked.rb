# frozen_string_literal: true

class DropIpsBlocked < ActiveRecord::Migration[5.2]
  def up
    drop_table :ips_blockeds
  end

  def down
    create_table :ips_blockeds do |t|
      t.string :user_ip

      t.timestamps
    end
  end
end
