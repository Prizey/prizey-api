# frozen_string_literal: true

class AddShopifyCustomerIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :shopify_customer_id, :string
  end
end
