class AddSortingToPurchaseOption < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_options, :sorting, :int, default: 0
  end
end
